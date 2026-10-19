Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87886606A319
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2026 21:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=hrtSzKBS;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=YKh++OOU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Htm41ZzW59EWMf0J7xg7vylcf3tC83jsLFLbZJNEvmc=; b=hrtSzKBSZj0EIpCKR9H8Q7UoHU
	UojPdGMv5nrWuZMnN4YerbeqoDFVeKiSGQc2O4W077NaRKlp1nY/kNtZcFvlrlD9AXwIyl+Jt73pZ
	M8KaNdUW7+qkqvIGyr8R26hMyAZXZ9U2ZjEFuu4WDYsunrTsHgOPgaXno0AnVRenN9lfHd3EEaSJw
	Iw6V02t/Xg0bjghCHPtkIArhjaKPyzXEjRyckcYyP5L5fzqK7zoKQlKlKhZAplRhIAFwXpfUUyYnB
	Z7WAGqYgh+pV9uf311Tl8kQeu8Wv9E8umYT8ejtAbw2YkcOvHJw/37DF+dBI0xTq1nkJCPU39tfKa
	SdmY/PuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIukz-00000008Mki-40QH;
	Mon, 19 Oct 2026 21:18:57 +0000
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIukx-00000008Mjy-2BO2
	for linux-nvme@lists.infradead.org;
	Mon, 19 Oct 2026 21:18:56 +0000
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4a1d75f2f11so17750435e9.3
        for <linux-nvme@lists.infradead.org>; Mon, 19 Oct 2026 14:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1792444733; x=1793049533; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Htm41ZzW59EWMf0J7xg7vylcf3tC83jsLFLbZJNEvmc=;
        b=YKh++OOUjzJ2AHLlSESbyvQLjh0/hq7+MkZaCZiKUN8hpd9QvEOEVNPico7sKUk48J
         35ZePmkPwOf8Sq1Q0otHNaopyn2do3TFM8OKhZlDS+Q0uHyJMrfsx8Pt6NRZGbjTYdSE
         Nfmg+sHCzjiqXmu3DcuSGIx2sYq9DWalRryKGmqt4T5+4dqUWv4XBWCei/2pwyaUckgy
         aA6ukscHUiX/UbXFc+NX/yAZtxE5rOuERFHDfOn0V+XuCwtZuEWFs7l1/ZB9B4JdO0Or
         qdtw9emV2rFr50nOvC69GmxIRgzWF2SOZ78ReTxTULsE8i/VJ9MfSjIv50Bjc41kIyMN
         osiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792444733; x=1793049533;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Htm41ZzW59EWMf0J7xg7vylcf3tC83jsLFLbZJNEvmc=;
        b=FX6IuTgxPwdwxKtAFHht9vMFCsfX2o7cs1S26I5E1aciIrinluSjrYbuQ52NZ/DJk5
         Y4gMFA4SsWwiBrQqitt+gZHrhOW47gp9xgjRHdF16Y31u3MFb9HoF5v+FnVdx4T64I0i
         pZpq/bD4bpSQ4MPQ9NcTaGJvN+kHRr6bbiaywtRA1yJFBLgXYq2pabVJTauc3yMPMLN5
         Ywz+NwyumilRCSLbZZYsA3w2qtOSfesYJlbEkLD1PWSP9LfNirpxaxubenfCLO7oUZeU
         WJq5nVBrMYbyuECrOBVL5LyqHPEfe+9B2XPPj8hJTQUuaIWtey+9vKjW4v95GZ8nKAPW
         WuhQ==
X-Forwarded-Encrypted: i=1; AKwUvBwaVBWo01IKW0s2j1xam7v1KLTJgO5ojiy/OCnOwYqtXIDRuRfU9Yo+Oo6PEuE3xt6FcF8DhxQnXwaa@lists.infradead.org
X-Gm-Message-State: AFq9FYJ3fSo13ngF3v36fkVXQGO6PU/zwzl62B0pvNmTjMYWb8k1BDQ5
	n2h7finScEnJlKcO8AJXJ4QKbncR28RN6Cg1zoDq+7xz+mFBwpWfV1fJ0s7v+RyuC4A=
X-Gm-Gg: AYBFou2/MxeeXVNt1RJR4y4k2JRmm/561pi095rfap+FlaTG/vxux3UPr7m41kvIxte
	Dn7tKgl7RW1fhmnQ78QW7Mdc4WtyMDMVfFTTohMwiV0vOhVDLZORUu0hA1k9lA8gQd74EIggxT+
	AZUGmGoDIOyeGbxuZ9XVfRZKcKaeTT3wVepaE+bjt5QHxFJn3tWFRVNrLf8VNeWOrBpMMX3v4nA
	EbZ/LSHang/wks/Gat3oubwnbniA7ivg8srMsJ4j8JxWt1jURPLdUTF2Nu9dThEuxRo8nA+3Nl+
	DYtIt1UFRCFD5TgqEJ2cE48S5fiXMEkHo1kK02/KXQpv1oXLDiQSIlOfsY1BNNRm0eCsVjlabjg
	Rx3pCC1dqsKczQsAp2rz9Qo8U21RLiXUDSl5ylj9otZvdZK4Jj4ttkBTKbCTWiY0RKJIUsvQ9s0
	QhcWrYzBFWLutZuNwIzxbzLpUI9HMIjEYLuu5prJPrYewzJv3+tApCf6Fs+VZuL0D8bQQQ+Y4xH
	3pjRNv5lHhWTaHChx4=
X-Received: by 2002:a05:600c:46d1:b0:4a1:de8a:603a with SMTP id 5b1f17b1804b1-4a1de8a63f7mr170070465e9.6.1792444733330;
        Mon, 19 Oct 2026 14:18:53 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4a1c8ce32absm208166855e9.1.2026.10.19.14.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 14:18:52 -0700 (PDT)
Date: Mon, 19 Oct 2026 14:18:49 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Daniel Wagner <dwagner@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>, Hannes Reinecke <hare@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	James Smart <jsmart833426@gmail.com>,
	Randy Jennings <randyj@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v6 06/18] nvme: Rapid Path Failure Recovery read
 controller identify fields
Message-ID: <20261019211849.GM2931-mkhalfella@purestorage.com>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
 <20260920182936.2317916-7-mkhalfella@purestorage.com>
 <179242896496.3619480.12975259904515722687.b4-review@b4>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179242896496.3619480.12975259904515722687.b4-review@b4>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261019_141855_763748_968EB78A 
X-CRM114-Status: GOOD (  25.34  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon 2026-10-19 18:56:04 +0200, Daniel Wagner wrote:
> > TP8028 Rapid Path Failure added new fields to controller identify
> > response. Read CIU (Controller Instance Uniquifier), CIRN (Controller
> > Instance Random Number), and CCRL (Cross-Controller Reset Limit) from
> > controller identify response. Expose CIU and CIRN as sysfs attributes
> > so the values can be used directly by user if needed.
> 
> What's the use case for it? This is an public/stable interface,
> it needs a justification and documentation

CIU and CIRN identify an instance of an NVMe controller. For a given
CNTLID different values of CIU and CIRN identify different controller
instances of the same controller. The justification is that the values
allow the user to identify a specific controller instance.

host# grep . /sys/class/nvme/nvme0/{cntlid,cirn,ciu}
/sys/class/nvme/nvme0/cntlid:1
/sys/class/nvme/nvme0/cirn:42541d24813bb536
/sys/class/nvme/nvme0/ciu:57
host# nvme admin-passthru \
  --opcode 0x38 \
  --cdw10=$(( 0x1 | 0x57<<16 )) \
  --cdw12=$(( 0x42541d24813bb536 & 0xffffffff )) \
  --cdw13=$(( ( 0x42541d24813bb536 >> 32 ) & 0xffffffff )) \
  /dev/nvme1
Admin Command Vendor Specific is Success and result: 0x00000000
host#

One usecase is to use the values to issue CCR command manually. Not that
I imagine one would want to do that, but if they want to do it they need
this information. CIU is also present in CCR log page. Someone reading
the log page might want to correlate a log page entry with a specific
controller, so they need the information to be exported somehow.

diff --git a/Documentation/ABI/stable/sysfs-nvme b/Documentation/ABI/stable/sysfs-nvme
index a2f5d0710db4..ebc3634c1a96 100644
--- a/Documentation/ABI/stable/sysfs-nvme
+++ b/Documentation/ABI/stable/sysfs-nvme
@@ -9,6 +9,17 @@ Description:
 		of the NVMe controller, as reported in the Identify
 		Controller data structure.
 
+What:		/sys/class/nvme/nvmeX/cirn
+What:		/sys/class/nvme/nvmeX/ciu
+Date:		October 2026
+KernelVersion:	7.5
+Contact:	Mohamed Khalfella <mkhalfella@purestorage.com>
+Description:
+		Shows CIRN (Controller Instance Random Number) and CIU
+		(Controller Instance Uniquifier) of the current instance
+		of the NVMe controller as reported by Identify Controller
+		data structure.
+
 What:		/sys/class/nvme/nvmeX/cntlid
 Date:		February 2016
 KernelVersion:	4.6

How about a diff like the one above for a documentation? I can add
something similar to the one above assuming the change will be merged in
7.5. Or I can add it later on? Maybe in an -rc after the change is
merged?

What do you think?

> 
> > Also add the nvme_fence_timeout_ms() helper that derives a fencing
> > timeout from the controller keep-alive timeout (kato).
> 
> There is no user in this patch, introduce it when you use it.

Moved the hunk to patch "nvme: Implement cross-controller reset recovery"
where the function is actually used.

> 
> -- 
> Daniel Wagner <wagi@kernel.org>

