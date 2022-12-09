Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88EB0C4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Dec 2022 06:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hEHtknj7G67yuPB9tWefZgr9ALjA/T5Vl29gdCA8cwI=; b=LSso8fpYGcCesdsbgbzvOioXAg
	Yr54BkNyU6x7zb5Abq7hcgiPTk7LgV2NdgdYy8IlFE0bImoN6PkUpebW0ve52vCTdhBqC0ZOpZS4s
	bfa+Y0k6WGrJepBIHY3I/99QJCz+FQLc5mgCpfn6TeriDdWIkXExTgsiiu3rtNNQ9hPKU0CPFG4JH
	/zNmDzwn0phbupEyWh9Z1zK2a+j3IYwHyX+5+HyJODU/FqLgP43V7FVrqKVfi34dpJdMfur1Jagsf
	53HDAU+ezXOEPrPmu3iPLP8Z18sUc7F3rwG9PTY6y2HwV9RbZRdO/Yz2tXNJPC3BPCqocB4xTVOuh
	WX6nvlfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p4cEV-008l0T-J4; Mon, 12 Dec 2022 06:24:12 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p3gai-009nam-Qn
	for linux-nvme@lists.infradead.org; Fri, 09 Dec 2022 16:51:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1670604673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hEHtknj7G67yuPB9tWefZgr9ALjA/T5Vl29gdCA8cwI=;
	b=cPRI/kR8AIBHENzdjGP712YpUpmzrnR0h3fuN+pIP+/u6CWbJLpt3jMyrt44ENSnjvuz9o
	fmkFnR3u2jOo5cESzoteQXGs/Kpd3d1K9yTrFGwajlCcoqwhqWtImOPeWZQmzp1oCerDT7
	fajW5URBIu/oXApIAtl0n9k3xeaYTAc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-13-TYzD3qhsMPSfzV1ToohmRA-1; Fri, 09 Dec 2022 11:51:10 -0500
X-MC-Unique: TYzD3qhsMPSfzV1ToohmRA-1
Received: by mail-wm1-f72.google.com with SMTP id bi19-20020a05600c3d9300b003cf9d6c4016so114585wmb.8
        for <linux-nvme@lists.infradead.org>; Fri, 09 Dec 2022 08:51:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hEHtknj7G67yuPB9tWefZgr9ALjA/T5Vl29gdCA8cwI=;
        b=lYD/oi0+0VlKxYni405mOwz6pzY6P9JC3Bsjvr2vp5xs6UvXl90RkbSE/HpqhtocKj
         fudN83CxwMMtX5p3t6lt+raF1ZLKifg8asgsRD2COhnyxxDZ5YoKPowa60HKLO4Ls5p7
         gB4u1GnSDkuIeS9vQnYRuFAxdUhwTbcBocz0Y8mE1NSHnzOSn1jHYDNKMiNrKTBeeIko
         7EOwXupU2ynMNXwaNoeBOE5SrOazSsuyUV6OEx6IRZGTx2NaTA3F+zqgLx2sxAgh8mre
         24I19W/E4hWggJwvXIK5DtxH/Vh0BXFjKCnyqd5Sn2f0iruU44FqrRYR30R/aohTbonh
         sntg==
X-Gm-Message-State: ANoB5pnXR5ETUL1RDpfceHNvn1JAya1JX+MtEKhdpDMs4AvXYqJZtNuq
	VrMKjm/OlmagzfKXMG/Yq9LL6QKet7Tns0egRVdi7xrYaYf695+IiGEsDew5AFg9VyJ+Mlv9uK8
	3CuB3zRipsfPtqJ8VnK95MVj+C30=
X-Received: by 2002:a05:600c:4f48:b0:3cf:e850:4435 with SMTP id m8-20020a05600c4f4800b003cfe8504435mr5700771wmq.13.1670604669135;
        Fri, 09 Dec 2022 08:51:09 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4vPLwblTckd8B2URRNRbKIW7VqMLQd/PWlQAHufJr6jh2xD5egmlwfWsaGwQofLy1f6L/9tQ==
X-Received: by 2002:a05:600c:4f48:b0:3cf:e850:4435 with SMTP id m8-20020a05600c4f4800b003cfe8504435mr5700758wmq.13.1670604668951;
        Fri, 09 Dec 2022 08:51:08 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-105-105.dyn.eolo.it. [146.241.105.105])
        by smtp.gmail.com with ESMTPSA id ay13-20020a05600c1e0d00b003c6bd91caa5sm302339wmb.17.2022.12.09.08.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 08:51:08 -0800 (PST)
Message-ID: <73186bd6e1ad62da16726b95b1a266c0aeb39719.camel@redhat.com>
Subject: Re: [PATCH v1 2/3] Treewide: Stop corrupting socket's task_frag
From: Paolo Abeni <pabeni@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Benjamin Coddington <bcodding@redhat.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>,
  Lars Ellenberg <lars.ellenberg@linbit.com>, Christoph
 =?ISO-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>, Jens
 Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>, Keith Busch
 <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
 <sagi@grimberg.me>, Lee Duncan <lduncan@suse.com>,  Chris Leech
 <cleech@redhat.com>, Mike Christie <michael.christie@oracle.com>, "James
 E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen"
 <martin.petersen@oracle.com>,  Valentina Manea
 <valentina.manea.m@gmail.com>, Shuah Khan <shuah@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, David Howells
 <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, Steve French
 <sfrench@samba.org>, Christine Caulfield <ccaulfie@redhat.com>, David
 Teigland <teigland@redhat.com>, Mark Fasheh <mark@fasheh.com>,  Joel Becker
 <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, Eric Van
 Hensbergen <ericvh@gmail.com>, Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Ilya Dryomov
 <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>, Trond Myklebust
 <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, Chuck
 Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
 drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
 nbd@other.debian.org,  linux-nvme@lists.infradead.org,
 open-iscsi@googlegroups.com,  linux-scsi@vger.kernel.org,
 linux-usb@vger.kernel.org,  linux-afs@lists.infradead.org,
 linux-cifs@vger.kernel.org,  samba-technical@lists.samba.org,
 cluster-devel@redhat.com,  ocfs2-devel@oss.oracle.com,
 v9fs-developer@lists.sourceforge.net,  ceph-devel@vger.kernel.org,
 linux-nfs@vger.kernel.org
Date: Fri, 09 Dec 2022 17:50:53 +0100
In-Reply-To: <20221209081101.7500478c@kernel.org>
References: <cover.1669036433.git.bcodding@redhat.com>
	 <c2ec184226acd21a191ccc1aa46a1d7e43ca7104.1669036433.git.bcodding@redhat.com>
	 <d220402a232e204676d9100d6fe4c2ae08f753ee.camel@redhat.com>
	 <20221209081101.7500478c@kernel.org>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221209_085116_952494_A6F6221A 
X-CRM114-Status: GOOD (  12.65  )
X-Mailman-Approved-At: Sun, 11 Dec 2022 22:24:04 -0800
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

On Fri, 2022-12-09 at 08:11 -0800, Jakub Kicinski wrote:
> On Fri, 09 Dec 2022 13:37:08 +0100 Paolo Abeni wrote:
> > I think this is the most feasible way out of the existing issue, and I
> > think this patchset should go via the networking tree, targeting the
> > Linux 6.2.
> 
> FWIW some fields had been moved so this will not longer apply cleanly,
> see b534dc46c8ae016. But I think we can apply it to net since the merge
> window is upon us? Just a heads up.

We will need an additional revision, see my reply to patch 3/3. I think
the -net tree should be the appropriate target.

Thanks,

Paolo


