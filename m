Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E1BC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jan 2022 13:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YAvabDKiy/IOq+tNORf8Ky3O1ISck19RzEYUA9eAKIQ=; b=Bl8cG1yQqErKm3C1cVeyfieZTv
	7e+vbIx37M2jF62q/tgO6GlfckMqz0q0MG4/7LZ5YpVI2uKmYJCZzpVD2xl4ZU3/9O5YJycY91PA5
	vlbCYph/O3v9o3tCstRIKDGYRLnOcVx1qm29vPOjpiqPbOBgrB4Uzs2gPyFJAvFMfpOERRdFdd+AI
	AZdVXORVLxbDYzQyST4LjBflyn207v+JoOF8x+IK8wORs5JJo/OMK/Sg8/bA7j1yOVgUbu/IfzkKg
	k9VvpTi/egyacjwaRtmkIn4lQTcLs52exqxCs25gzgUKHLiHCwXc4G//ye8j0Mts/qjBcSobPTvkm
	2Y0fNwhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nD4TI-00FoxP-Aa; Thu, 27 Jan 2022 13:05:52 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nD4TG-00Fow5-58
 for linux-nvme@lists.infradead.org; Thu, 27 Jan 2022 13:05:51 +0000
Received: by mail-pl1-x636.google.com with SMTP id x11so2426087plg.6
 for <linux-nvme@lists.infradead.org>; Thu, 27 Jan 2022 05:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=YAvabDKiy/IOq+tNORf8Ky3O1ISck19RzEYUA9eAKIQ=;
 b=g/hFiPCc8RFLsEjhhtRjCcx2vGN8zYVWT9S/1sdO14X6so0hUQZqHCyQZuJfuBEPzA
 UT3JfWn3l99awvTiybM3F2i5eZVLH6pctJqJ3keCIrFjVst89kNFdKQZ9cXqSGe0QhFQ
 6ZmaRrGqzTPCBCtBDjIyGFxxt72MMxyrrzOyrstXGLC9zLAlC1h2tcod4u7WGAXGJtQj
 uOzQDmgDF5+auOABzTDx+4vD5Tt3JS6RRzU6x0TioMBz0lxmpURPRrJ6ZW2KOOBI0WU4
 MX9uhpNOsEMGcNQrlK51LmLO1QHSVJbIJ5o5C5JgNT1U1I8iCPs7BlAnpAYaR1yz58fN
 xYKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=YAvabDKiy/IOq+tNORf8Ky3O1ISck19RzEYUA9eAKIQ=;
 b=UFDsS0YyD486XwVN9oUl25EmpLY3d+6n2Lqq9pGp5nKzdxinJz/l3VkVvTmx/3zTSC
 UgAaadpq/dgzvBqLxRCIwI4b9ptdSCeNct44ZA000stbCsnlxxg74svnP5jNlil6lTcr
 p0lM3u0zMajAUL8o5T09shPeb7CZZG4+5zoR5vgmssetI2oDI1etUTjoxkxJz3vIrakp
 jeRs3cLQ/M3+kdJe6VWGZGIn1IHCRiA7OJJu9vFHnHPMQP0D/vukEQtlXQH9WI78KK8L
 RVs0vzN5/yoIKymWzLqvbMDvG5cI4mwJni1ncAOOpbncvbrAR66OAeG304IpwqOuwL5a
 fR9g==
X-Gm-Message-State: AOAM532ZLeKjkg3vQz6klmyVF+krh3KWWF9saaS6l6bA5Vm4L8kK+fkS
 kxyiDfy4Jr7hB8BM+YsfxXI=
X-Google-Smtp-Source: ABdhPJz5mf/XYBMviEo7nzNv/zu76bfGBYRz+uXYVP6cf2ycU+TIoBUSvXKieTwhBg70VojSq85z/g==
X-Received: by 2002:a17:90b:33c9:: with SMTP id
 lk9mr13750657pjb.41.1643288747435; 
 Thu, 27 Jan 2022 05:05:47 -0800 (PST)
Received: from localhost ([182.65.162.251])
 by smtp.gmail.com with ESMTPSA id nv13sm6578735pjb.18.2022.01.27.05.05.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jan 2022 05:05:44 -0800 (PST)
Date: Thu, 27 Jan 2022 18:35:41 +0530
From: Pankaj Raghav <pankydev8@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Pankaj Raghav <p.raghav@samsung.com>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: Use pci_iomap instead of ioremap
Message-ID: <20220127130541.qxb6vk5lhoaa4ivl@quentin>
References: <CGME20220121143539eucas1p20202376f83b0b499143c18b1434ff000@eucas1p2.samsung.com>
 <20220121143533.164928-1-p.raghav@samsung.com>
 <20220126163306.GB31892@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126163306.GB31892@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220127_050550_227918_CED3D6A8 
X-CRM114-Status: GOOD (  11.42  )
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

On Wed, Jan 26, 2022 at 05:33:06PM +0100, Christoph Hellwig wrote:
> pci_iomap goes with the ioread/iowrite accessors which we absolutely
> do not want in nvme.
Is it because of ioread/iowrite has a conditional check everytime we do
a read/write with IO_COND? Or is there any other reason?

--
Pankaj

