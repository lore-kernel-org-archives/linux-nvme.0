From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 7 Sep 2017 11:20:33 +0200
Subject: [PATCH] nvmet: Add support for reservations.
In-Reply-To: <CAJgS9SXJsQDxxzpjraCdWMP8rxxzkiApt1Nm84jrhk+b56AFvA@mail.gmail.com>
References: <1504529987-27343-1-git-send-email-omri@excelero.com>
 <20170904142606.isnbgq7b3o5mvwls@linux-x5ow.site>
 <CAJgS9SXJsQDxxzpjraCdWMP8rxxzkiApt1Nm84jrhk+b56AFvA@mail.gmail.com>
Message-ID: <20170907092033.rthu2m4e37ffc7xv@linux-x5ow.site>

On Thu, Sep 07, 2017@11:40:54AM +0300, Omri Mann wrote:
> A list of registrants, protected by RCU, is kept for each namespace and a
> reference for the reservation type and holder.
> Each I/O operation is checked for reservation conflict.
> 
> For every change in the reservation status that warrants it, a log page
> entry is generated for each controller that should receive it, and an
> Asynchronous event is sent to all relevant controllers that have not
> been sent one since the last time they have read the reservation log page.
> 
> Reservation status structures definitions were copied from nvme-cli.
> 
> This patch does not include support for persistency across power failures.

This is something I don't relly like. How about adding it to configfs and
signal userspace via a uevent or sth. like that so we can call nvmetcli store
(or something along that lines).

Byte,
	Johannes

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
