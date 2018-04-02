From: ckulkarnilinux@gmail.com (chaitany kulkarni)
Date: Mon, 2 Apr 2018 01:03:21 -0700
Subject: [PATCH] nvmet: fix nvmet_execute_write_zeroes function
In-Reply-To: <93622938-f532-b8ac-2bca-fe40ed759e71@linux.vnet.ibm.com>
References: <1522444730-2060-1-git-send-email-rosattig@linux.vnet.ibm.com>
 <20180330212439.GA28945@localhost.localdomain>
 <93622938-f532-b8ac-2bca-fe40ed759e71@linux.vnet.ibm.com>
Message-ID: <CAK0tqikdyFoZGuRnh3_YXKtrY9NqEZVv5AysL+xGKpvGJ762fA@mail.gmail.com>

Please give me a couple of days, I'll look into this.

On Fri, Mar 30, 2018 at 2:48 PM, Rodrigo Rosatti Galv?o
<rosattig@linux.vnet.ibm.com> wrote:
>
>> Doesn't that mean your host is using this command wrong? The NLB is a
>> 0's based value, we're supposed to +1 to get the correct block count.
>
>
> Keith, I tested passing different values to the c (number of blocks) and s
> (64-bit LBA of first block to access) parameters, and it was failing. When I
> removed the +1, the command worked fine.
>
> I used a simple script to validate this:
>
> for s in {0..20}
>     do
>             for c in {0..20}
>             do
>                     nvme write-zeroes /dev/nvme0 -n 10 -s $s -c $c
>             done
>     done
>
>
> Is there some other way to test it?
>
> --
> Rodrigo R. Galv?o
> Intern - Linux Technology Center - IBM
>
>
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
