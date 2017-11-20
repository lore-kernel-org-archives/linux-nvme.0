From: thomas.tai@oracle.com (Thomas Tai)
Date: Mon, 20 Nov 2017 15:04:36 -0500
Subject: parse_and_open without closing the fd
Message-ID: <1c333ba1-5371-fa03-12fa-72ae42c7cc52@oracle.com>

Hi there,
I am trying to add a new command in nvme-cli and use flush() in nvme.c 
as an example. The flush command use parse_and_open() to open the fd, 
but it never close the fd. I am wondering where about the fd is being 
closed.

Thank you very much.
Thomas
