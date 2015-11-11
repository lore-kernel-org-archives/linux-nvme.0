From: keith.busch@intel.com (Keith Busch)
Date: Wed, 11 Nov 2015 22:14:33 +0000
Subject: nvme: controller resets
In-Reply-To: <CAKajsGNGvWw1+B7X8HxdvP0MyvAawb_PStu_adOC8wogOF-Fbg@mail.gmail.com>
References: <33aa688b8da3f41960d36e66aa1703d8@localhost>
 <20151110155110.GA31697@localhost.localdomain>
 <CAKajsGOdxWzK8TfpaLYpf25h=ZRfQbxRW47Q4aAHhCOunLK+FQ@mail.gmail.com>
 <CAKajsGNGvWw1+B7X8HxdvP0MyvAawb_PStu_adOC8wogOF-Fbg@mail.gmail.com>
Message-ID: <20151111221433.GA11250@localhost.localdomain>

On Thu, Nov 12, 2015@03:26:04AM +0530, Vedant Lath wrote:
> [  235.496753] nvme: submit: QID 1 CMD opcode 2 flags 0 cid 1 NSID 1
> [  235.496755] nvme: submit: rsvd2 0 metadata 0 prp1 5897535488 prp2
> 2318221568 slba 41495303 length 0 control 0 dsmgmt 0 reftag 0 apptag 0
> appmask 0

Let's examine the above command.

You've got PRP1 set to 0x15f854000, and length set to 0 (1 block). Based
on other info provided on this device, a block is 4k.

Seeing PRP1 is 4k aligned and you're transferring 4k of data should
mean you only need one PRP. Your command however shows PRP2 is used and
pointing to a list (must be a list rather than data since the offset is
0x100 aligned).

Either your new prints are incomplete, or there's a nasty bug somewhere.
