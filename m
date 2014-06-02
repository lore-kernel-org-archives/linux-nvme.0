From: keith.busch@intel.com (Keith Busch)
Date: Mon, 2 Jun 2014 14:08:26 -0600 (MDT)
Subject: A NVME command always generates some additional commands?
In-Reply-To: <CAMjVwgQZQ9R+FD2sPhdLraGhdf-8OrwZngMTQVfVMh1__5QFhg@mail.gmail.com>
References: <CAMjVwgQZQ9R+FD2sPhdLraGhdf-8OrwZngMTQVfVMh1__5QFhg@mail.gmail.com>
Message-ID: <alpine.LRH.2.03.1406021342500.11244@AMR>

On Mon, 2 Jun 2014, Angelo Brito wrote:
> We are developing a NVMe device and your device is under tests right
> now. So we are monitoring what is requested, what is executed and what
> are the answers. Then every time we request a NVMe I/O Command some
> additional 23 I/O Read Commands are generated to read some blocks next
> to the end of our memory or next to the start. Is it an expected
> behavior? I didn't find a reason at the driver for these commands to
> be generated.

Reads are generated everytime you close a block device opened for writing.
