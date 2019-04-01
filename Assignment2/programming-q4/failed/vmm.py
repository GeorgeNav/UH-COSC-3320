import os


def disk_usage(path):
    """Return disk usage statistics about the given path.

    Returned valus is a named tuple with attributes 'total', 'used' and
    'free', which are the amount of total, used and free space, in bytes.
    """
    st = os.statvfs(path)
    free = st.f_bavail * st.f_frsize
    total = st.f_blocks * st.f_frsize
    used = (st.f_blocks - st.f_bfree) * st.f_frsize
    return [free, total, used]

data = disk_usage('/')
print('Free: ' + str(data[0]) +
      '\nTotal: ' + str(data[1]) +
      '\nUsed: ' + str(data[2]))  # [free_bytes, total_bytes, used_bytes]
