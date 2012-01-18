From: Kwok.Kong@idt.com (Kong, Kwok)
Date: Wed, 18 Jan 2012 11:49:30 -0800
Subject: Suggestion on NVME IOCTL Pass Thur command
Message-ID: <5AC4D6A45304E048A30F105EB302760902F73D0E@CORPEXCH1.na.ads.idt.com>

Matthew,

I have a suggestion on the IOCTL Pass Thru command data structure
format. Please review it and let me know what you think.


Currently, you have two different structures for the IOCTL command; one
for admin and the other for IO commands as in the followings:

struct nvme_user_io {
	__u8	opcode;
	__u8	flags;
	__u16	control;
	__u16	nblocks;
	__u16	rsvd;
	__u64	metadata;
	__u64	addr;
	__u64	slba;
	__u32	dsmgmt;
	__u32	reftag;
	__u16	apptag;
	__u16	appmask;
};

struct nvme_admin_cmd {
	__u8	opcode;
	__u8	flags;
	__u16	rsvd1;
	__u32	nsid;
	__u32	cdw2;
	__u32	cdw3;
	__u64	metadata;
	__u64	addr;
	__u32	metadata_len;
	__u32	data_len;
	__u32	cdw10;
	__u32	cdw11;
	__u32	cdw12;
	__u32	cdw13;
	__u32	cdw14;
	__u32	cdw15;
	__u32	timeout_ms;
	__u32	result;
};


May I suggest to combine them into a single format. 

i.e.

struct nvme_pt_cmd {
    __u32	nvme_cmd[16];
    __u32	nvme_cpl[4];	/* copy the completion entry to here on
return */
    __u32	direction;
    __u32	timeout;
    __u32	result
    __u64	metadata;
    __u64	data_addr;
    __u32	metadata_len;
    __u32	data_len;
};

We need to return the completion queue entry because DW0 contains a
command specific field and DW1 is reserved. A vendor defined command may
use DW0 and/or DW1. If we return the 16 bytes completion entry, the
caller can do whatever they want to do with the completion entry. One
may argue that DW2 does not need to be returned but it is probably
easier to copy the whole 16 bytes completion entry.

Instead of looking at the opCode to decide the direction, a direction
field may be better. A Vendor defined command does not need to  set the
data transfer bits.  A direction field makes it very clear for the
application and the driver.


In the Windows driver, the following commands are not allowed to be sent
by the application. 

- Delete IO queue (submission and completion)
- Create IO queue (submission and completion)
	# IO queue cannot be created/deleted while the driver is active
- Abort
	# application cannot abort a command is it does not know the
command ID
- Set features - number of queues
	# application cannot allocate queues
- Asynchronous Event Request
	#application cannot handle completion of AER.
- Read
- Write
	# There is no reason for the application to issue read/write
directly as there are system call to 
      # perform read/write already.

I think the Linux driver should block these commands as well. 


Thanks

-Kwok
