Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3ABFC3ABAA
	for <linux-nvme@archiver.kernel.org>; Mon,  5 May 2025 13:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T5h2sJr9byZhs4OyrawZ8yiqoBdPBORhWSUiI7/JHP0=; b=tPkyPPBHdhVJWYJeGI60betGP5
	N+CNZCMkZkiKrhQEGCToIBu92gmkJ33GexqCV4zSKE5rAhwPQyUyocgq6BWJIPZ5RT7/f0wF9b3jr
	jaXPqlpNwU3UgqW/V09YmuP/Vt9XD0qGtrv4hwHfNNbdKtQ3+9/TfdAdr9XyBS5osQ2eZP62LWhgf
	qzawaqOEEyKq0QxeYXgBaI/ScFK12+ELbeiIU11m+IMChnTkb9WqGqnMlx02zCD7yTFBm3zkHEM8t
	9X8yBdjiIWA/AnH2FA3rNi47c0TWFbzRnBvVBZukFTiJTe5DkD1uuFoY+sxjkOn2If13032XBHfQa
	LtQ9eHjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBwEF-00000007Xbq-14nR;
	Mon, 05 May 2025 13:51:31 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBwCa-00000007XPv-0BEP
	for linux-nvme@lists.infradead.org;
	Mon, 05 May 2025 13:49:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746452986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T5h2sJr9byZhs4OyrawZ8yiqoBdPBORhWSUiI7/JHP0=;
	b=EXlsizbzbFhlxL8NxwVUxJHaTIdslgTpMnESCR/R5DWXuPEAUJV3HMH+J40bEoBy23dbN2
	U05mvO4+9PzDYcv4V9khZVK/HDnB+XLjGMBLodtfLXc4yZv7TGK3Eb6Vi8qLVFjeQVrsDn
	8ePx7+pnGa3nZZhYcVB7fUqguKmNE2M=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-r2JdeSFBNMSxsHotM4zZ5w-1; Mon, 05 May 2025 09:49:45 -0400
X-MC-Unique: r2JdeSFBNMSxsHotM4zZ5w-1
X-Mimecast-MFC-AGG-ID: r2JdeSFBNMSxsHotM4zZ5w_1746452985
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-401c6b8b66fso3632621b6e.1
        for <linux-nvme@lists.infradead.org>; Mon, 05 May 2025 06:49:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746452984; x=1747057784;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T5h2sJr9byZhs4OyrawZ8yiqoBdPBORhWSUiI7/JHP0=;
        b=tywC6CwhuTDaBi/OPXG1VxN3gvjuayqqcN2Xnt6RFwtT5OR92DMa5gMWVfytrfriit
         yZv0sSxzwT+4gGs9tHuLguaQg5nC+CojLTdsvYXc4eZCwOOTIsh/hVMje01HRiqdMVJj
         aZ0CPD3e2xpc5aryLBJSRiKbwQymn5kUYnyB5VAXG/hY0gBHuGtwkvNSH9GwF/ZuAWrA
         zP3OyV4btcPz71bImsVFuxY5maL9HX3Wlg2JlV5grf+Gv3YFFJsfoC02wpme1LWkrHFe
         64BXRsiLgZ28cFw/01hUgHSmdLKA0Ut4dbbqsKrTinho46o1AJG3wDHoPXlGUxNy4ud7
         ocoA==
X-Forwarded-Encrypted: i=1; AJvYcCV2BoQl9XwM/doR1LveeinWB/szSp7+mJZ7ex/8E9uVGmY8+VacYq4hZ5F+xL8P1vc3nA/+F7U/olzZ@lists.infradead.org
X-Gm-Message-State: AOJu0YzdBa/AnjuEdm3F34v++amhXUbbzz482/d3jR6Yl64sTyFspLfI
	qCrHn94/dOCD/Nl8TkS1pCEbAyyw+t0bGUOTKnhl2LrJe8jtZnXJdSdZexdQ75/NAuhW4MLbhfo
	992ucit2tYIo4IkrzDWRnzVSZptuzuhk6DtiSmzxFf8iN1K3axRG5PVJOPxaRLInVJHJDokgR
X-Gm-Gg: ASbGnctJOPevlUWXh893Wv6JjdMQU/e3RQcR6Owv/qzSCvhTxZsBGVnuPeJew1/mJ/2
	rcE9yolVJBtYSKflWwWCObbNTOSRsE0vw1OSWSuWdoxmulKtolXg9StD8ixnE0Vm//3nr3JR7yK
	aRyNZjc7Ud+QZl3hagkLEhtPOtKz/z5kMy1cMy00k1bVUbtCTUN7HponrwqNsSqFV9KcNH+6eS3
	kbSilhTSDJ+RhiQhhDMbj4SJSUfxegUBjBA65GxTIHTeLiMfrOXOwJCDHpbrzrnatWNI40y1b+f
	Q3EXZQVNYPgMryjfUstGIk+8r/LdZ47yKYjr1pgxu8grMEJHtcSb2bffMGQYcQ==
X-Received: by 2002:a05:6808:3442:b0:401:e61b:fe9c with SMTP id 5614622812f47-4035a584fc5mr4286163b6e.20.1746452984280;
        Mon, 05 May 2025 06:49:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9hT/2W357mr92XrQXI+siG1Hjd/JDZUe8WR13F/oyFQ9naJ6hk6FE2ND0wS8bYsozKEX+/A==
X-Received: by 2002:a05:6808:3442:b0:401:e61b:fe9c with SMTP id 5614622812f47-4035a584fc5mr4286152b6e.20.1746452984040;
        Mon, 05 May 2025 06:49:44 -0700 (PDT)
Received: from ?IPv6:2600:6c64:4e7f:603b:fc4d:8b7c:e90c:601a? ([2600:6c64:4e7f:603b:fc4d:8b7c:e90c:601a])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4033d9c21d9sm1883112b6e.14.2025.05.05.06.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 06:49:42 -0700 (PDT)
Message-ID: <0da89e8321755b798b47d17da76b7e28d28c43b9.camel@redhat.com>
Subject: Re: [PATCH 0/2] nvme: handle partially unique NID value
From: Laurence Oberman <loberman@redhat.com>
To: Javier Gonzalez <javier.gonz@samsung.com>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Judy Brock <judy.brock@samsung.com>, 
 "Ballard, Curtis C (HPE Storage)" <curtis.ballard@hpe.com>, Hannes Reinecke
 <hare@suse.de>, "hare@kernel.org" <hare@kernel.org>, Sagi Grimberg
 <sagi@grimberg.me>, "wagi@lst.de" <wagi@lst.de>, 
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Date: Mon, 05 May 2025 09:49:40 -0400
In-Reply-To: <heivqjw2a33ero36rit3uyu3h377jym35caeg3amnkhk5ra7wf@eodk7wld4j6b>
References: <3e6fb1f6-d6f0-4f33-9389-dff37daae7b0@suse.de>
	 <20250414114128.GA13822@lst.de>
	 <PH0PR84MB1358448342C273E7C7BA808898BC2@PH0PR84MB1358.NAMPRD84.PROD.OUTLOOK.COM>
	 <CGME20250502082359uscas1p1e2a9858dcc9200ab1d1d863c4495fc0a@uscas1p1.samsung.com>
	 <eee8de0a44074dd3bfb0fc6ec425b647@samsung.com>
	 <20250502102505.GA13055@lst.de>
	 <27a99b458f0144fba094726e4f470552@samsung.com>
	 <aBWRfiwJkeYGB0Og@kbusch-mbp>
	 <r5b5gwy6vf56ropgbcx6fyi6qvgnwtzvdz5xjnofln3jvcx2zm@d4dvfkawab2x>
	 <20250505111111.GB11508@lst.de>
	 <heivqjw2a33ero36rit3uyu3h377jym35caeg3amnkhk5ra7wf@eodk7wld4j6b>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: g7SbrDi0rYrpPQMZauxwVkONH5d5cxewjL6kEtA8VPY_1746452985
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250505_064948_159252_8B7223E6 
X-CRM114-Status: GOOD (  23.94  )
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

On Mon, 2025-05-05 at 15:08 +0200, Javier Gonzalez wrote:
> On 05.05.2025 13:11, Christoph Hellwig wrote:
> > On Mon, May 05, 2025 at 11:51:39AM +0200, Javier Gonzalez wrote:
> > > I think we should let HPE distros carry this quirk for drives
> > > where they
> > > would not want to roll a FW update.
> >=20
> > Or just goddamn people to upgrade the broken firmware.=C2=A0 Without it
> > their data is at risk, so they'd better do it.
> >=20
> > Also maybe this is a lesson to SSDs vendors (and I really mean all
> > of
> > them) that if they can't push back ob broken "features" due to
> > market
> > dynamics they should at least OEM brand the devices in the identify
> > data so that the blame gets deflected to the right party.
>=20
> Agree. The dynamics of how OEMs want to apply FW updates is up to
> them,
> but there is no doubt this has been a mess. Hope we have learned a
> lesson...
>=20

Seems what I sent last week is the same issue.
For now we will fix this in a RHEL only kernel until the vendor gets
F/W fixes out.
There are a lot of devices out in the wild already I guess, that have
this issue

Thanks
Laurence


