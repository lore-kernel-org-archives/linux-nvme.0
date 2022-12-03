Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5258C352A1
	for <linux-nvme@archiver.kernel.org>; Sat,  3 Dec 2022 04:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:To:In-Reply-To:Cc:References
	:Message-Id:Date:Subject:Mime-Version:From:Content-Transfer-Encoding:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ccD2JrUqoo8dGTQE9lIA6Ic8NF4n65yiBkZdSFL8aqk=; b=WNYT3+EUgRtCh5t76yLzNgwele
	GsD7PefeeeiZ0VEghF3OfNcWfKPxkiv2twlf8+mQohMSokH0oqiSoOBCuVrtGnaNOJEHByuvYoKz0
	mC4iXraCTmcMuwNyOujQXkM5D5b4C3Ix+yXSVyu/Lks/kDpTVgsG+lirjxC1zM31Z6BPK0o+0H7sg
	+nCWt4jJEOx9DwIBCxAb1istHqVXlauhyHLk2yk+CuwcgCa6V4CpmFq9aeCMNKjQbOW+3rx2ThwIX
	YXmHTKX3GDUxWsEW1P0qLZBPsEMx3ITkR9GmOiV3byxTCNPUx6HyeowX0qrIGcekAp18MbJrB7+x+
	I0de7Mrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p1K00-002Lhd-KE; Sat, 03 Dec 2022 04:19:36 +0000
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p1Jzy-002Lh0-4g
	for linux-nvme@lists.infradead.org; Sat, 03 Dec 2022 04:19:35 +0000
Received: by mail-lj1-x229.google.com with SMTP id r8so7476930ljn.8
        for <linux-nvme@lists.infradead.org>; Fri, 02 Dec 2022 20:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20210112.gappssmtp.com; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ccD2JrUqoo8dGTQE9lIA6Ic8NF4n65yiBkZdSFL8aqk=;
        b=CABa0c6Z8GB68LpfcT6ifNmMsRl7DojSt4Fz1SE0rQ5YTWctV66UCulvr3VgqKgoPM
         C8XUke796Bj/HUETpCMj69/cGSEj0lU8xCpBLAHjeANAQ07/qld/hw+W732EEmu5Ghtw
         ob24fAgs3ragUTh6oQvWZHvxqpi01iWPHK9X+81oVWSvCBtue4daxQkaz9pdB1B0Qc3z
         PYnL5RsoKUmqc9z+sum4t4NTPJwft9tylToWPiTLf3kPle1ukpBEeQwlZOYto9xy4ATd
         8jTZ5KbajYSifVbIbmsKlcBeDvSgPI/dFKN38mEqDjt4LyeVg6xPThyCiWzBnvK8UQ/q
         SQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ccD2JrUqoo8dGTQE9lIA6Ic8NF4n65yiBkZdSFL8aqk=;
        b=G/iy6yTgPtW6tWccXpYrYINTRC/e3vhJ8MszIScIlfLLvJUMx3SHd5pDplkXHs/mUv
         D2Tmvq2emT8DgGTwEq1JdDkatccOLm1r6kIFqBFc6h3FBCno0RUccuyORbDA5ly/40Ei
         NPgJzruLW2/0lWsK3zCtDzNsaXQYfY3VtgESbxjJ2IWi0C1ylz4qD1JmYyGTGCYcre9m
         WhxQuknnuW0GnKBmqnqgVzIz0oKm/YIYRaDUCdJsPUVkvvbGDmhRWkHYnNnIfR8GQ4Wr
         b1a2wEwtIq4TvPtytw2A6fzlhrjoaXL7D+ZBZRxL0INmzI6QqsjXfWqKu2I1b5ST+J86
         rD2w==
X-Gm-Message-State: ANoB5pnnS1Ufi2tMRNVRDTpHL9ldsBbVXjCOTt6ZY3eV9xDv8eUvKSkr
	wKB3skLQg6nR4DuJVAyC1TBbtg==
X-Google-Smtp-Source: AA0mqf7wH0C0pDIAs+KLfjhRNQCtQ/GYw24Q7zFEM++AAYMYahqX8fgtbDrgd5iOVZMlUmFCMtte/A==
X-Received: by 2002:a2e:be08:0:b0:277:857:87ab with SMTP id z8-20020a2ebe08000000b00277085787abmr16751284ljq.442.1670041170764;
        Fri, 02 Dec 2022 20:19:30 -0800 (PST)
Received: from smtpclient.apple (77.241.136.54.bredband.3.dk. [77.241.136.54])
        by smtp.gmail.com with ESMTPSA id z8-20020a056512370800b004a91d1b3070sm1243597lfr.308.2022.12.02.20.19.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 20:19:30 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 0/6] block: add support for REQ_OP_VERIFY
Date: Sat, 3 Dec 2022 07:19:17 +0300
Message-Id: <4F15C752-AE73-4F10-B5DD-C37353782111@javigon.com>
References: <Y4oSiPH0ENFktioQ@kbusch-mbp.dhcp.thefacebook.com>
Cc: Hannes Reinecke <hare@suse.de>, Matthew Wilcox <willy@infradead.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, linux-block@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, axboe@kernel.dk, djwong@kernel.org, hch@lst.de,
 sagi@grimberg.me, jejb@linux.ibm.com, martin.petersen@oracle.com,
 Johannes.Thumshirn@wdc.com, bvanassche@acm.org, dongli.zhang@oracle.com,
 jefflexu@linux.alibaba.com, josef@toxicpanda.com, clm@fb.com, dsterba@suse.com,
 jack@suse.com, tytso@mit.edu, adilger.kernel@dilger.ca, jlayton@kernel.org,
 idryomov@gmail.com, danil.kipnis@cloud.ionos.com, ebiggers@google.com,
 jinpu.wang@cloud.ionos.com
In-Reply-To: <Y4oSiPH0ENFktioQ@kbusch-mbp.dhcp.thefacebook.com>
To: Keith Busch <kbusch@kernel.org>
X-Mailer: iPhone Mail (20B82)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221202_201934_433598_1CB89FC7 
X-CRM114-Status: GOOD (  10.34  )
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


> On 2 Dec 2022, at 17.58, Keith Busch <kbusch@kernel.org> wrote:
>=20
> =EF=BB=BFOn Fri, Dec 02, 2022 at 08:16:30AM +0100, Hannes Reinecke wrote:
>>> On 12/1/22 20:39, Matthew Wilcox wrote:
>>> On Thu, Dec 01, 2022 at 06:12:46PM +0000, Chaitanya Kulkarni wrote:
>>>> So nobody can get away with a lie.
>>>=20
>>> And yet devices do exist which lie.  I'm not surprised that vendors
>>> vehemently claim that they don't, or "nobody would get away with it".
>>> But, of course, they do.  And there's no way for us to find out if
>>> they're lying!
>>>=20
>> But we'll never be able to figure that out unless we try.
>>=20
>> Once we've tried we will have proof either way.
>=20
> As long as the protocols don't provide proof-of-work, trying this
> doesn't really prove anything with respect to this concern.

Is this something we should bring to NVMe? Seems like the main disagreement c=
an be addressed there.=20

I will check internally if there is any existing proof-of-work that we are m=
issing.=20=

