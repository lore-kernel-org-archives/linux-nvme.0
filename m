From: andrzej.p@samsung.com (Andrzej Pietrasiewicz)
Date: Wed, 23 Nov 2016 09:35:36 +0100
Subject: [PATCH] usb: gadget: uvc: fix returnvar.cocci warnings
In-Reply-To: <2122146.rzc0RNY0pB@avalon>
References: <201509170828.xv0cYNA5%fengguang.wu@intel.com>
 <alpine.DEB.2.10.1509171056470.2399@hadrien> <55FAA16C.5070601@samsung.com>
 <CGME20161122172658epcas4p43c58fc9861747068b50cc7af9337f692@epcas4p4.samsung.com>
 <2122146.rzc0RNY0pB@avalon>
Message-ID: <3504c280-fe7f-9ec2-0f92-2b6aea290080@samsung.com>

Hi Laurent,

Thanks for a reminder.  Please see inline.

W dniu 22.11.2016 o 18:27, Laurent Pinchart pisze:
> Hi Andrzej and Julia,
>
> Could one of you please submit a patch to fix this ?
>
> On Thursday 17 Sep 2015 13:18:04 Andrzej Pietrasiewicz wrote:
>> Hi Julia,
>>
>> W dniu 17.09.2015 o 10:57, Julia Lawall pisze:
>>> Coccinelle suggests the following patch.  But the code is curious.  Is the
>>> function expected to always return a failure value?

As a matter of fact it seems it should not return anything at all,
because...

>>
>> Thank you for catching this. The function is not expected to always
>> return a failure value. Fortunately it does not matter anyway because

...because
>> the return value of the drop_link() operation is silently ignored by

And the Documentation/filesystems/configfs/configfs.txt says here:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/filesystems/configfs/configfs.txt#n397

"When unlink(2) is called on the symbolic link, the source item is
notified via the ->drop_link() method.  Like the ->drop_item() method,
this is a void function and cannot return failure."

The ->drop_item() is indeed a void function, the ->drop_link() is
actually not. This, together with the fact that the value of ->drop_link()
is silently ignored suggests, that it is the ->drop_link() return
type that should be corrected and changed to void.

@Joel: What is your opinion? Should return type be changed to void?
Is there any reason why it should still be declared int?

I'm sending a copy of this mail to target-devel and linux-nvme,
because other potentially affected users of configfs live there.

AP
