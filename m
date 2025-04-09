Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 935ECC36002
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Apr 2025 11:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iCcGsnPUzqjNb9NVxPyTVXQsBz1cE3TukB1xa3SP8wc=; b=bLdFIW6jNWMPlqVKGzCK3sFRm5
	jWLXAg2TlVATcqUzYEGkCwmHtyONoauOieJ7wjJDtNU7/PJgNLWXHNl22WZbS1hC16V/vegvwd2fD
	VDH44iBru9SUA07NYnZ9rS0T9HFMm7T6SWPh5cOQeqhDCg0v1TunO1O4jA7TUuFCej7/4Sq8eLlDJ
	s3s+5O+lHy1gfTayPL3m4/UjlstC6yQK/pn1U+7YdzIePFn5PQWWw2HM68iN0Y7w8oOgZL8TGgg6+
	Jom1E77TVoMF3O6puiQUjFEztIe7b7874DziAjtYwxSMlobnaCJoJNvSEQ1BcMWNbYQnRKjxzT553
	fXHH2BZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2U4f-000000074OP-3P4V;
	Wed, 09 Apr 2025 11:58:33 +0000
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2U4d-000000074N0-1Bqd
	for linux-nvme@lists.infradead.org;
	Wed, 09 Apr 2025 11:58:32 +0000
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-6ff07872097so61242997b3.3
        for <linux-nvme@lists.infradead.org>; Wed, 09 Apr 2025 04:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744199910; x=1744804710; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iCcGsnPUzqjNb9NVxPyTVXQsBz1cE3TukB1xa3SP8wc=;
        b=d4UhdPUaL2c1R58ep36BKOD9Xcl0xC1aG1TVN5ZbEshKsbbEkMGJZgcjZzNg2HqdQr
         7ls8cw5IR2VLeuUbE7pFqWhu+7GycJ/4/ZFFDnl34S5BR6q4Nl1ZhJkvdd0Ms9K3aO0H
         tfOAhsEelAgw1bkZ1kObQlefb+WWMcItMI09uVAUs5d7FnVbvfz+lR97v6C4tjZUwJ8r
         b3DmOkMOguCBtYPF5F9LZ4OwT4JjVKRQQox1eOJ/7LTL5Ljpk0HOb9Ljn+JX2Z+YUZm9
         Edgx2ncCe5w3naRcmrx8YSCABy2RkN6MM+nT0z+h9euhRWB2SG6Ma7c23heUrG8bnU1Z
         2sCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744199910; x=1744804710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iCcGsnPUzqjNb9NVxPyTVXQsBz1cE3TukB1xa3SP8wc=;
        b=N65M3Ni02vj/i1D85yGxhyBRmPipG/e3Kf3P7STuTPBK7uJ/p2JN8z9nFaax7qwITR
         JqQ8+P+6Civix9oLMyiUP15sDNuTBNkEWUSkEiwlfHzLfNlAMt/A8A4u/DAj5w9j14As
         gvNWLG0PxZ6sEX6EbHnzoXiWcLAEMQuF7gFgBxPKgMOB6bzlb9XSqW4aYR4/XvHPZCV4
         0vzzuf9CurDDiM0LjrJYFigUfJRBswGdDr9PE2TYBGW0d2n94bN7Cf/YemRMwKgDX5nn
         k7mNQ2SCVirpX9W2j4y6va+8slHq7XQuwytALTTLxfm+PJrsJJaYCsh9o80EDkvGvi7i
         6AEg==
X-Forwarded-Encrypted: i=1; AJvYcCX2/YDVPdzqxntTWN2Fbb6jxEJr5NDPhJepuAHVO+ZbeBZ+ysUV1najCA/kZJI0YLrJXU3CW+IlS+6v@lists.infradead.org
X-Gm-Message-State: AOJu0Ywlc3LxuGmOBhzpfRc5MY66o1xbzUEJABfKNeUevcxOA8WbrRFo
	VkwTsn3EjnnIO56LJbDVI1GPSWdORz6ZEE8T+dLsllj6VX/gLpFft8j4Wn4P093w9nJyDte22gZ
	Npmctz8vjJv/fS4wfL3B/uT8MOoO6Zc0R
X-Gm-Gg: ASbGncvc22/5BS1Lu4SLdMVkbzRSI2qc2f+9/+kDHGsvKw1VYTlnLSd/aCRGR1ebNcM
	ERyp5IuDpACmK/Va/ub7soD0bheQqtdSUjs3PAF0tdb8VPW1nKdoMrcBs9ivCDmfEzl6EyvPlFk
	U5m4YTcIb/v7nV+zVNIGDQ2SmBhNoMKF8OkXw=
X-Google-Smtp-Source: AGHT+IFLK8Cspc1ygCIAQzpQ/GnMIKEr51qHcZbnkCIsSTrCvfQZ+KqRN4BNvnaTXxNkzPd2/zNJaNANapk+n2uSXRg=
X-Received: by 2002:a05:690c:fcc:b0:702:52fb:4649 with SMTP id
 00721157ae682-7053ae70b56mr34162417b3.27.1744199909885; Wed, 09 Apr 2025
 04:58:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAAiJnjpzCfDViPDsixbyOe3V3w5EMDa-ScEt0jod9b-YJjJw7Q@mail.gmail.com>
 <Z_Y3AYFzE3L2ujBW@infradead.org> <527963f3-1b89-4604-bc76-b3a18bb330a6@flourine.local>
In-Reply-To: <527963f3-1b89-4604-bc76-b3a18bb330a6@flourine.local>
From: Anton Gavriliuk <antosha20xx@gmail.com>
Date: Wed, 9 Apr 2025 14:58:17 +0300
X-Gm-Features: ATxdqUGD0lJadbGFfeC5wbEAA8camfu6P-SgBMDMd8OnY-x9S2f2i8AnrkirZmc
Message-ID: <CAAiJnjoft3gSsg-TYgyiBVpWiTjWztF=3E-aJpuaeZLCNrT-hg@mail.gmail.com>
Subject: Re: nvmetcli restore fails in add_subsystem
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>, Daniel Wagner <wagi@kernel.org>, linux-nvme@lists.infradead.org, 
	Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250409_045831_330887_76A57C60 
X-CRM114-Status: GOOD (  18.73  )
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

Hhmmm.....

The link - https://documentation.suse.com/sles/15-SP6/html/SLES-all/cha-nvm=
eof.html

is quite confused me,

17.4.3 Marvell

FC-NVMe is supported on QLE269x and QLE27xx adapters. FC-NVMe support
is enabled by default in the Marvell=C2=AE QLogic=C2=AE QLA2xxx Fibre Chann=
el
driver.

So if "the qla2xxx driver or/and the HBA firmware do not support the
target mode anymore.", it is not clear, will NVMe/FC target work with
QLE269x and QLE27xx adapters or not.

> Though he was able to get the target mode running with a Emulex HBA (lpfc=
 driver).

Long live Emulex!

P.S., I don't like FC, but I want to do some NVMe/FC vs TCP
performance tests, so I must set up NVMe/FC for the tests.

Anton

=D1=81=D1=80, 9 =D0=B0=D0=BF=D1=80. 2025=E2=80=AF=D0=B3. =D0=B2 14:40, Dani=
el Wagner <dwagner@suse.de>:
>
> On Wed, Apr 09, 2025 at 01:59:45AM -0700, Christoph Hellwig wrote:
> > On Tue, Apr 08, 2025 at 01:53:09PM +0300, Anton Gavriliuk wrote:
> > > I'm trying to set up an NVMe/FC target on Fedora Server 42 beta.
> > > Config file attached.
> >
> > I haven't seen such a failure, but I have also never used nvmet with
> > the fc transport myself.
> >
> > Daniel, have you seen anything like this by chance given that you
> > are the most active nvme-fc developer at the moment?
>
> As far I can tell, the qla2xxx driver or/and the HBA firmware do not
> support the target mode anymore. I was not able to get this working
> either and IIRC Hannes said something similar.
>
> A colleague also tried to get a with a QLogic HBA working and failed.
> Though he was able to get the target mode running with a Emulex HBA
> (lpfc driver).
>
> Daniel

