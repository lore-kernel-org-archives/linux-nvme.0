From: zouming.zouming@huawei.com (Zou Ming)
Date: Mon, 10 Jul 2017 18:17:19 +0800
Subject: [PATCH 7/7] nvme: Send change uevent when AEN completes
In-Reply-To: <1499444581-28268-8-git-send-email-keith.busch@intel.com>
References: <1499444581-28268-1-git-send-email-keith.busch@intel.com>
 <1499444581-28268-8-git-send-email-keith.busch@intel.com>
Message-ID: <f1589f67-f3ea-e16a-a99c-f79afb9b6216@huawei.com>

Hi Keith:
   Thanks,Send All AEN info to user space looks good to me.

   In addition I have a question, is there a scene where repeated asynchronous events are received?
   Because the event is sent to the user space for asynchronous processing, and at the same time issued a new asynchronous event request command.
   The user space may be processed slower than the issued command, resulting in a duplicate asynchronous event report.

Best regards,
Zou Ming.

On 2017/7/8 0:23, Keith Busch wrote:
> This will give udev a chance to handle asynchronous event notification
> and clear the log to unmask future events of the same type. Since the
> core driver allows only one AEN request at a time, we can only have one
> possible oustanding uevent to send. This implementation saves the last
> AEN result from the IRQ handler, and sends the uevent change notification
> when the AEN work is rescheduled.
