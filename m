From: kwan.huen@samsung.com (kwan.huen)
Date: Mon, 20 Apr 2015 18:47:41 -0700
Subject: Write with Stream ID Support
Message-ID: <1429580863-3451-1-git-send-email-kwan.huen@samsung.com>


The attached patch set enables basic write with stream ID support. 
First patch reads the stream id embedded in the bio and passes to the 
device along with the write command.
Second patch adds two new nvme commands to be used with ioctl 
such that application can do open/close stream and host
initiated garbage collection.
