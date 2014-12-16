From: zabushima@micron.com (Zakaria Abushima (zabushima))
Date: Tue, 16 Dec 2014 15:03:28 +0000
Subject: nvme_ioctl_submit_io issue
In-Reply-To: <alpine.LNX.2.00.1412161453120.4026@localhost.lm.intel.com>
References: <37D709DA9AEECD448AE8DD01BDD193F7ED9BAE@NTXBOIMBX02.micron.com>
 <alpine.LNX.2.00.1412161453120.4026@localhost.lm.intel.com>
Message-ID: <37D709DA9AEECD448AE8DD01BDD193F7ED9C15@NTXBOIMBX02.micron.com>

I actually updated it to the following char data[4096], which is 4096 byte, each block is 512 and with 8 blocks we are allocating exactly as the required size ?

-----Original Message-----
From: Keith Busch [mailto:keith.busch@intel.com] 
Sent: 16 December 2014 15:01
To: Zakaria Abushima (zabushima)
Cc: linux-nvme at lists.infradead.org
Subject: Re: nvme_ioctl_submit_io issue

Your command is broken, but I can't say why that breaks your controller. The data buffer is 8 bytes on the stack, but you've set nblocks to 7. Assuming a block is 512 bytes, this command is expecting 4k worth of data and that's what the driver is going to map.

On Tue, 16 Dec 2014, Zakaria Abushima (zabushima) wrote:
> Hi Guys,
>
> I try to write to the name space using following application,
>
>               static const char *perrstr;
>
>               char data[] = "Zakaria";
>               struct nvme_passthru_cmd write, compare;
>               struct nvme_user_io io;
>
>               int fd, err;
>
>               perrstr = argv[1];
>
>               fd = open(argv[1], O_RDWR);
>               if (fd < 0)
>                              goto perror;
>
>               io.opcode = nvme_cmd_write;
>               io.flags = 0;
>               io.control = 0;
>               io.metadata = (unsigned long)0;
>               io.addr = (unsigned long)data;
>               io.slba = 0;
>               io.nblocks = 7;
>               io.dsmgmt = 0;
>               io.reftag = 0;
>               io.apptag = 0;
>               io.appmask = 0;
>
>               err = ioctl(fd, NVME_IOCTL_SUBMIT_IO, &io);
>
>               if (err < 0) {
>                              goto perror;
>               }
>               if (err){
>                              fprintf(stderr, "nvme write status:%x\n", err);
>               }
>               fprintf(stderr,"status : %x\n",err);
>
>               close(fd);
>
>               return 0;
>
> perror:
>               perror(perrstr);
>               return 1;
>
> For the first time I had  " device busy error ",
>
> Then when I ran for second time the nvme0 and namespaces has 
> disappeared from /dev/ directory
>
> Any idea of what happens
