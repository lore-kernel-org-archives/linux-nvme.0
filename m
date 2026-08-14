Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C05C7C5CFCF
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2026 14:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NmU7z6OC249KBM2h0aoOKXqrafvecetknhvjJZj4jUg=; b=xvldlIzbdDhkPWPq8Gu8IhPUgk
	N6V8hFnvCJXQeRSo0y1FtqJtsVaesqs/Mnc3PHhDMMwDAUndh04v0K8n86MiFa74UEPaN738jE09c
	35YIuow9PRf8cK1pOE1BXo9m008l6pbYjPiVsLwjh886tWlg2LXSi+4egdoRZ6dHt17EUPKt5qNfi
	KvVm1tZNrMhGz1/bCyimqABPI63bu/e0/M3Qf9VXx96egzBxOtTOOXq+sYX8q1KeZEeMYRBC7sQSu
	u6/yKppdks+e1usoy+3otbV1IuS1tK3J6ePHRw9X4Blp4yYVcMo1fSgBpYqnhYq8VbrO7RFRq0Pca
	occGfsqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuskK-00000002mPv-0dTr;
	Fri, 14 Aug 2026 14:18:56 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuskH-00000002mPa-1DU6
	for linux-nvme@lists.infradead.org;
	Fri, 14 Aug 2026 14:18:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786717131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NmU7z6OC249KBM2h0aoOKXqrafvecetknhvjJZj4jUg=;
	b=TBOeKH62RpdkVtiOmi2Fc0LjEuiXgzYbZhwVk3rjxTT7XjoOmHIyTieZcSNatNHI/+kxW+
	1Fzr1x9D4MdDWB5VgttnSCVjcFnAX81hiL8mXckMMUQZaRBq2U5TARn82G+CbuFCXSZ3wT
	bs1/DRAVpRj8RYoDEF++p2xyck7DybY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-jVrkzFh-PNKKb7At53L7jA-1; Fri, 14 Aug 2026 10:18:43 -0400
X-MC-Unique: jVrkzFh-PNKKb7At53L7jA-1
X-Mimecast-MFC-AGG-ID: jVrkzFh-PNKKb7At53L7jA_1786717122
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47fecbb7f88so710539f8f.0
        for <linux-nvme@lists.infradead.org>; Fri, 14 Aug 2026 07:18:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786717122; x=1787321922;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NmU7z6OC249KBM2h0aoOKXqrafvecetknhvjJZj4jUg=;
        b=B8CslHXNELR6S8RsJyPXevbci8i+4cCfy8iu4Rt3SjaHaLkiMKJC7BDJ9sTAtjlhkA
         QTct1TjNK7upyra99fivvZDIfAVTT1Jcnfhn6j3I3kT2gH2kiWPMtoWgZkaCfT9gnzAB
         uK1uMW9ggU64vVAlTv3xsIdDcE/wu++in7v0A6FFOwMrSLC2uGMXJZSroi0nP6eb8FMd
         2q6WVfj8jz0nV5jRwhdegyJrBdkmTqbslCb6+fm2xP/yHrX9UjiDhh7ff2/3T1bj1FAi
         6kjYmObPrSzli+lCoGGk5I4l/ox2SWWLzmDDqpBjRFYFJgTWgdZc5cw130c2KxKRCiEr
         IbjA==
X-Forwarded-Encrypted: i=1; AHgh+RpyjydxAKBFylrNzBWniN15iec5qwpS9CzZ7c7Nl17flEF2j25HvYFUS4eX2DO1P8XTQFv7cHgiHrdi@lists.infradead.org
X-Gm-Message-State: AOJu0YwfSJnKLixLnHSOHbYiw74+NLZbD+RplTSUTgdIUyDpctf4kepb
	Q7/uNjJxPiiVOPJ3kU1/EmDrMHD7soexFP6vSJJLqrW16BNPilKzPzzaxiz0XVRRZTpyRGH2tBW
	3HCshI/rmTtm127U2KgC6k9lGHIWXP4qSbv3HPLmSKA6g7VJa+wRjn8xWJkYauZC3EFi/CT9Bl7
	p5cs10iZGUx8XmPZhTx8LQgSwOB1E7MAYo6DqIGODwkJE=
X-Gm-Gg: AR+sD12+uDlg2ZN38OmAHmkz84KHBnMcVIAQ7FspsX84G3PJWbPD9N/nZx1GvnoOwq5
	tkoZmxoUesKeYI2g3f8d62hQ/NWE/U6TKVUj/aVfB3IJUTVFbLdVk/Ys/YNXeO5+X+Q9QltLC9B
	6uDkQcD0wkYNPYIuGCkR12U4eZ9BCc121bIV17D7P9p1zJJxeV7gc2+XIH7vziz9mV1Py32gICN
	FWEP6DWeoPepQQu5w==
X-Received: by 2002:a5d:588b:0:b0:47f:9568:ebf0 with SMTP id ffacd0b85a97d-4816076e5d6mr8567197f8f.23.1786717122035;
        Fri, 14 Aug 2026 07:18:42 -0700 (PDT)
X-Received: by 2002:a5d:588b:0:b0:47f:9568:ebf0 with SMTP id
 ffacd0b85a97d-4816076e5d6mr8567119f8f.23.1786717121682; Fri, 14 Aug 2026
 07:18:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260812174503.3705830-1-jtaubepe@redhat.com> <an75bRJc8J6NexeH@shinmob>
In-Reply-To: <an75bRJc8J6NexeH@shinmob>
From: Jesse Taube <jtaubepe@redhat.com>
Date: Fri, 14 Aug 2026 10:18:29 -0400
X-Gm-Features: AcwNN1W-_eBVIwPeU4L2Msiij6dBncE2vb0x-B7AGUvsZOMgUKDIjjcSxeVZJZI
Message-ID: <CADRr4beUeZo9ZA9TZVmWQ9Vegm2LvTXkW0wGNxYA6_7z_njMEA@mail.gmail.com>
Subject: Re: [PATCH blktests 0/2] Test multipath and marginal ports
To: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	John Meneghini <jmeneghi@redhat.com>, Daniel Wagner <dwagner@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ujgt7HAsYU-QB08bHpZp76lJyR_7BVIXarx57sK8Rxk_1786717122
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260814_071853_403761_2FA2DA1E 
X-CRM114-Status: GOOD (  16.21  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Aug 14, 2026 at 7:25=E2=80=AFAM Shin'ichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> Hi Jesse, thanks for the patches.
>
> On Aug 12, 2026 / 13:45, Jesse Taube wrote:
> > Tests for the upcoming nvme-fc: FPIN link integrity handling set.
>
> I assume that above refers to this kernel patch series.
>
>   https://lore.kernel.org/linux-nvme/20260812181300.3712426-1-jtaubepe@re=
dhat.com/

Yes it does

>
> I applied the series on top of v7.2-rc7 kernel. Then I ran the test case =
added
> by this blktests series and observed the failurea below:
>
> nvme/070 (tr=3Dfc) (test nvme-fc marginal path handling)       [failed]
>     runtime  33.581s  ...  33.028s
>     --- tests/nvme/070.out      2026-08-14 12:03:21.338000000 +0900
>     +++ /home/shin/Blktests/blktests/results/nodev_tr_fc/nvme/070.out.bad=
       2026-08-14 20:17:04.731000000 +0900
>     @@ -2,7 +2,8 @@
>      Starting background I/O
>      Testing iopolicy: numa
>      Changing FC links to online
>     -Set all online: pass
>     +No FC ports are being used, expected atleast one in use when all are=
 online in numa mode.
>     +Set all online: fail
>      One host marginal: pass
>     ...
>     (Run 'diff -u tests/nvme/070.out /home/shin/Blktests/blktests/results=
/nodev_tr_fc/nvme/070.out.bad' to see the entire diff)
>
> Is this failure expected?

No. I can't reproduce the issue either.
Does this happen consistently?
Maybe the links are still connecting?

Thanks for you review I will implement the changes you recomend.

Thanks,
Jesse Taube

>
> I will comment on each patch in line.
>


