From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Wed, 14 Aug 2019 00:37:32 +0900
Subject: [PATCH v3 5/6] ledtrig-blk: add interface to stop and restart
 polling disk stats
In-Reply-To: <e1ece602-b413-b391-c7c3-34a8e46254c4@gmail.com>
References: <1565459703-30513-1-git-send-email-akinobu.mita@gmail.com>
 <1565459703-30513-6-git-send-email-akinobu.mita@gmail.com>
 <e1ece602-b413-b391-c7c3-34a8e46254c4@gmail.com>
Message-ID: <CAC5umyjjdi8QCw+Bi8hy+F6b9g0o8sqot9eWistW81yaBjAtDw@mail.gmail.com>

2019?8?13?(?) 4:31 Jacek Anaszewski <jacek.anaszewski at gmail.com>:
>
> Hi Akinobu,
>
> I don't see any vital reason to keep this change separately.
> We're introducing new trigger, so please just squash it with
> the patch 4/6.

OK.  I'll take care of renaming led to led_trig in the patch 3/6, too.
