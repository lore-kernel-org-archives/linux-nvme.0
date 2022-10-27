Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81BA3ECAAA1
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Oct 2022 13:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aHJrykbiwTNLJIe7EbXuyKbCXSqMZfYVQ6KFrKh6/nw=; b=hbfoLSvCUc3oTdJYvyy6BMLklI
	DkCvrkpwuBfKjkSIBAFw3JdfRd8L9FBLFfd7r/S504GckEWOiPdFCROTVCksqqaf5SPI1oWuBMBO4
	aVBTsQiAy+00sGZS3QpE9ASmrkDwG0Mpo7RfE53GfCwSsj1GP2OqHbub4+pbDy4E5WCJz9P2jWjOz
	OmGNk3vkjrkvcFXsYVdElotI8UskhYCypsJ5NHFQJsAtFGUu5ooX6k2torVSL3v3IpZMO64FGc6sW
	ws/wrjvpCm062BGL1rsrx0Yj/GuGzwB9yBlcPyWrrilKUtBJsDh/0mQ+o/6zXHYTuWuLb8XV8E4T5
	AYWsMmCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oo2z2-00DXcG-Vk; Thu, 27 Oct 2022 13:31:45 +0000
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oo2ii-00DORk-ER
	for linux-nvme@lists.infradead.org; Thu, 27 Oct 2022 13:14:56 +0000
Received: by mail-lj1-x22a.google.com with SMTP id z24so2456017ljn.4
        for <linux-nvme@lists.infradead.org>; Thu, 27 Oct 2022 06:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aHJrykbiwTNLJIe7EbXuyKbCXSqMZfYVQ6KFrKh6/nw=;
        b=jOaeyjAfM+Aq7eFd9bsHgjaCQnQP5LgW/xXnJPiPCToRiY4nRm73rcaWCadPv/rRrW
         ZXvPt2eUCiXdte1DB6/gfOzJLnrT+G2AKcnc1j7Zg2UJ1CDejjSUyeY5WtJBBQpwWdMy
         bCaO82htFZtwEtcUQhngNo/sQ19dSU3AWf9dZGb3EQ+b2JzuryKNYQo9+JNj/jy+TD/+
         9Vt+MrrBDAgz4Vy7+99zCTlijTqh5uJSOYPG6li0AkvNx+4N20/Xcb1f6YAJWErU6acl
         Pzl6W8USqOtxw8TzIQmturt54E/EJXrxCwOkKvC/ow9ALOMuElg+cl6nPWKhOD1pRPyf
         YM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHJrykbiwTNLJIe7EbXuyKbCXSqMZfYVQ6KFrKh6/nw=;
        b=U95B6WwCQRp99HbqJhKCd6HUN/2HODSj9+bOY1dRjlxTgjeNeGtQ0oRlNlaUl1JL7a
         GEmUcQTwoukPuCbHHLRhRDE34YdlJT0MWjgqh+tQ4ZK7cF0KrAf9ARgu1XRKJvUjCBXF
         VTcR08iyVNJFr2qsIKTsRBuCBMtBYGkmjvbrlrSK/UgGj9Nyv58+HmOeZBQd93oQ7pir
         2oW2C/OA4rkfdSQZrrtfACQC9nTxge9FeGoJqRN/J2waDan07jjo3EN8faaW5AtOMqqT
         YahDLuTBDq4TxAPnVOy6r/SiK7/HTT8zm4RFq+onP60aeXwhVrRDz3QczupwqMHSDM/s
         VY3A==
X-Gm-Message-State: ACrzQf2rP009RRpCLDwyBRgFkVolBl02GdQ5rhru0Vl8FsFY9Sjy9b4A
	nR9cbrRRcaeRfRT/51AAxv0=
X-Google-Smtp-Source: AMsMyM67XPg1PMbZAwqPNyu1OzPVjgulJDpVsmKSAJR7Tu7vPk0UDNv6XohHwIBMNFZPQ+ziRtLewg==
X-Received: by 2002:a2e:a551:0:b0:26f:ced4:af36 with SMTP id e17-20020a2ea551000000b0026fced4af36mr17528386ljn.90.1666876488868;
        Thu, 27 Oct 2022 06:14:48 -0700 (PDT)
Received: from localhost ([2a02:aa7:4608:fa87:af37:47bd:6e7e:6e5a])
        by smtp.gmail.com with ESMTPSA id m3-20020a056512114300b004a050ddc4ecsm183431lfg.125.2022.10.27.06.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 06:14:48 -0700 (PDT)
Date: Thu, 27 Oct 2022 15:14:46 +0200
From: Pankaj Raghav <pankydev8@gmail.com>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>, Daniel Wagner <dwagner@suse.de>,
	Alan Adamson <alan.adamson@oracle.com>,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH] nvme: quiet user passthrough command errors
Message-ID: <20221027131446.ptbt5z7lbvlnivo3@quentin>
References: <20221026170715.2657664-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026170715.2657664-1-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221027_061452_504794_57C034D5 
X-CRM114-Status: GOOD (  11.06  )
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

On Wed, Oct 26, 2022 at 10:07:15AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The driver is spamming the kernel logs for entirely harmless errors from
> user space submitting unsupported commmands. Just silence the errors.
> The application has direct access to command status, so there's no need
> to log these.
> 
> Cc: Daniel Wagner <dwagner@suse.de>
> Cc: Alan Adamson <alan.adamson@oracle.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> 
Shouldn't we also add a Fixes tag here?

