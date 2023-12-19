Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25825C46CD2
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 04:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Khn/qxVb/1GMNJeFqv5wOwCeaJ
	yUnR5kkgdGkPj++XWp1JJo+a4vfSvrMhk3iey9ZHnqP01N7JXNURWLr1I4uLOXXW1HmefSZwHo1Mf
	9bSgJIXLrQKI9HOXLawn3v1NGkvZYnBP0OPEOQMPr2cpOqW6TuQFv0EhQz3o4Q0bwzW/lC8PweDV4
	scnY6chFGaAOhjgikUxQEVFFx6LIbXxAhTNdrjF7OzZsf/4KiosYu6ktZlM0ZC3OSp7AhbAxFpFKy
	Zs12yk/4qkyc5gk1T8DCgPT+k/I0ArmXXpBTnQ1RCUFHFVkWU1cks/t+fZ4oxnxtkTZJkkYlmrpkZ
	LU0Ta5xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFRlj-00CnhD-1S;
	Tue, 19 Dec 2023 04:31:47 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFRlg-00Cng6-1B
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 04:31:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B60C468AFE; Tue, 19 Dec 2023 05:31:40 +0100 (CET)
Date: Tue, 19 Dec 2023 05:31:40 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3 05/16] nvmet-fcloop: Remove remote port from list
 when unlinking
Message-ID: <20231219043140.GF30580@lst.de>
References: <20231218153105.12717-1-dwagner@suse.de> <20231218153105.12717-6-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218153105.12717-6-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_203144_551892_3F23786C 
X-CRM114-Status: GOOD (  10.02  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


