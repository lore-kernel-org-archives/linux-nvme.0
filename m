From: keith.busch@intel.com (Keith Busch)
Date: Mon, 10 Jul 2017 13:38:29 -0400
Subject: [PATCH 7/7] nvme: Send change uevent when AEN completes
In-Reply-To: <f1589f67-f3ea-e16a-a99c-f79afb9b6216@huawei.com>
References: <1499444581-28268-1-git-send-email-keith.busch@intel.com>
 <1499444581-28268-8-git-send-email-keith.busch@intel.com>
 <f1589f67-f3ea-e16a-a99c-f79afb9b6216@huawei.com>
Message-ID: <20170710173829.GF14788@localhost.localdomain>

On Mon, Jul 10, 2017@06:17:19PM +0800, Zou Ming wrote:
> Hi Keith:
>    Thanks,Send All AEN info to user space looks good to me.
> 
>    In addition I have a question, is there a scene where repeated asynchronous events are received?
>    Because the event is sent to the user space for asynchronous processing, and at the same time issued a new asynchronous event request command.
>    The user space may be processed slower than the issued command, resulting in a duplicate asynchronous event report.

The driver can have only one async event request outstanding, so it
can't have more than one uevent available to send. The driver will send
the KOBJ_CHANGE prior to sending the next AEN request, so that should be
sufficient if anything is monitoring the events.
