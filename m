From: omri@excelero.com (Omri Mann)
Date: Thu, 7 Sep 2017 11:40:54 +0300
Subject: [PATCH] nvmet: Add support for reservations.
In-Reply-To: <20170904142606.isnbgq7b3o5mvwls@linux-x5ow.site>
References: <1504529987-27343-1-git-send-email-omri@excelero.com>
 <20170904142606.isnbgq7b3o5mvwls@linux-x5ow.site>
Message-ID: <CAJgS9SXJsQDxxzpjraCdWMP8rxxzkiApt1Nm84jrhk+b56AFvA@mail.gmail.com>

A list of registrants, protected by RCU, is kept for each namespace and a
reference for the reservation type and holder.
Each I/O operation is checked for reservation conflict.

For every change in the reservation status that warrants it, a log page
entry is generated for each controller that should receive it, and an
Asynchronous event is sent to all relevant controllers that have not
been sent one since the last time they have read the reservation log page.

Reservation status structures definitions were copied from nvme-cli.

This patch does not include support for persistency across power failures.

On Mon, Sep 4, 2017@5:26 PM, Johannes Thumshirn <jthumshirn@suse.de> wrote:
> Hi Omri,
>
> a bit more information (a.k.a. a commit message) would be helpful to review
> your patch. Also I do not see how you intent to make persistant reservation
> survive across reboots.
>
> Thanks,
>         Johannes
>
> --
> Johannes Thumshirn                                          Storage
> jthumshirn at suse.de                                +49 911 74053 689
> SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
> GF: Felix Imend?rffer, Jane Smithard, Graham Norton
> HRB 21284 (AG N?rnberg)
> Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
