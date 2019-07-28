From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sun, 28 Jul 2019 12:12:06 +0900
Subject: [PATCH 3/4] nvme: lightnvm: trace opcode name
In-Reply-To: <bf4212ea-8c08-61eb-39cd-c43a5186125c@lightnvm.io>
References: <20190727184155.18014-1-minwoo.im.dev@gmail.com>
 <20190727184155.18014-4-minwoo.im.dev@gmail.com>
 <bf4212ea-8c08-61eb-39cd-c43a5186125c@lightnvm.io>
Message-ID: <20190728031206.GA24390@minwoo-desktop>

Hi Matias,

> We should not pollute the standardilized NVMe code with vendor-specific
> opcodes. The above code assumes generally that an opcode is associated as an
> admin opcode - this is true for an OCSSD 1.2 drive, but not so for any other
> vendor's drive.

Agree with that.  I was thinking that these are nothing but an opcodes
which could be not a pollusion, but you're right other vendors are not
suitable for these opcodes.

> Besides that, I don't think we should add anymore code for 1.2 since it is
> deprecated.

Okay, I think I need to think about how to trace the nvme commands for
the vendor-specific commands with minimal changes.

Thanks!
