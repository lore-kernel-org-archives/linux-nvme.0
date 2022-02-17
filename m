Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F4AC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Feb 2022 01:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cK/B5LPhFrjMxTQlkSj0W2EXcO7lXH9qkZ05XTZiSUQ=; b=VutA2HsLJ2k7leHmOGeYnD/5RN
	fFhBE4B/gTzytF36p1gxkjEY1RPbfpvEwJMAyadjTgnZFo9C2lxwVbPjPQ4q1zi9mtlLxlrsnCnr/
	ozes+D96a7GhNgyYER2wKMb95XwaBwG7RUVutf087Hetzznc2rTOVKNcHiDbV016rDUJYl3qGRNc5
	gYd4ZastAv/bRLoOsH7D9MMVllo4Zc9maIAgC5LQpsL3venxOAX3dWtJn+RjFqfIyKt372gdGSICd
	mHcHfSSS4HHdNw27RsKTqQjZJW8PMBqqnb9f5/RuXKQ/nW6ZlnD2yccPNcRnFt3ESAyk0VWIRcwL3
	tiEcXOSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKVD9-008cGa-Au; Thu, 17 Feb 2022 01:03:55 +0000
Received: from mail-pl1-f181.google.com ([209.85.214.181])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKVD6-008cFd-4t
 for linux-nvme@lists.infradead.org; Thu, 17 Feb 2022 01:03:53 +0000
Received: by mail-pl1-f181.google.com with SMTP id y18so3340381plb.11
 for <linux-nvme@lists.infradead.org>; Wed, 16 Feb 2022 17:03:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=cK/B5LPhFrjMxTQlkSj0W2EXcO7lXH9qkZ05XTZiSUQ=;
 b=uebCtQ0Du3aHkMLBORF8I9mS/CXC307g9/cwHRSm+FoWHOVy0pCWN86ZD/XF8kbiNr
 vtKpKe1d/EsxwVSCi++RB+rqtZo8oWQlvI+UGp1jEOUEMJFXo5CjGjI4PxD5sCyOTJNu
 gq4O75hOOQWErgvq1CZNRerhuhR7O6mwNIyzf+b6JRcg2OKJ90UAXjr2FBFqvKbprb5H
 OD1GgAcaRik7R0MZ4Kdnl38xgRXv/xdBAM5Xo1e88qp/Qu3r02ZFrCO4/MKhu4brK4AE
 F3ljpDozurnjzLgPgqsncDmWJg2qMi+4PZjAmTKkpDXBFymGuui/g9CuHCfDRahPwM96
 lkmg==
X-Gm-Message-State: AOAM532lLEDKar/D+szRMzGrbH2zbM/Dld7g8b3wGm+jdOGcP04JTJdB
 y94XMJ2EPM1B17v/k3a1VB4=
X-Google-Smtp-Source: ABdhPJylnnnC1an21rCotApMu7vno6eYEiR9q1Ke7wjlxLuxciJNGuYt+VE13QbaH8O2YwI7zRn/9Q==
X-Received: by 2002:a17:90b:33c9:b0:1b9:15d9:4968 with SMTP id
 lk9-20020a17090b33c900b001b915d94968mr4787847pjb.214.1645059826890; 
 Wed, 16 Feb 2022 17:03:46 -0800 (PST)
Received: from garbanzo (136-24-173-63.cab.webpass.net. [136.24.173.63])
 by smtp.gmail.com with ESMTPSA id w23sm6546635pgm.14.2022.02.16.17.03.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Feb 2022 17:03:45 -0800 (PST)
Date: Wed, 16 Feb 2022 17:03:43 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org, joshi.k@samsung.com, hch@lst.de,
 kbusch@kernel.org, linux-nvme@lists.infradead.org, metze@samba.org,
 mcgrof@kernel.org
Subject: Re: [PATCH 7/8] net: wire up support for file_operations->uring_cmd()
Message-ID: <20220217010343.uvw2yuanqo2viv3a@garbanzo>
References: <20210317221027.366780-1-axboe@kernel.dk>
 <20210317221027.366780-8-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317221027.366780-8-axboe@kernel.dk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220216_170352_197300_DD5E94EE 
X-CRM114-Status: UNSURE (   9.21  )
X-CRM114-Notice: Please train this message.
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

On Wed, Mar 17, 2021 at 04:10:26PM -0600, Jens Axboe wrote:
> Pass it through the proto_ops->uring_cmd() handler, so we can plumb it
> through all the way to the proto->uring_cmd() handler.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Without a user I think this is just a distraction for now, although a
nice proof of concept.

metze,

do we have a user lined up yet? :)

  Luis

