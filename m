Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FBE7C3DA6D
	for <linux-nvme@archiver.kernel.org>; Tue, 20 May 2025 13:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SN6rVeOG9ro2f4EpT8Y76K3vFhJJc0qzSGO5p6iaxLo=; b=UPxI06LQeG4dBGqnjEzzBOYbrq
	egoLV7UVibxfL+rGN2zp4xAizDlspNvtqM6PbTaR288DT3MpR0dhTfBkEGVR59GotJn9S8uUSEzQp
	KbpN0bt0kZshauzWvEQr9BcH7/S4WTtbIroRvyGVx1HVRC5oo5lRIdYRy56x6dUeswxQIMc9++Mw1
	3ZgRi5aVsjFEw8dG1GmpRD72U9nimot0Ra6HxvyUq82sOUE5yuD5ENmcp/RjRHzVXLX7LUPI3E+Hg
	MWaTHTvMYgHzIxee15Q7Fp9hAawziVqBsiAIg7tW3CdSejt2boxSSfjCyC8Qzlr/92Wfmru/9cJIM
	y/+v+gCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHN6o-0000000D1oN-1qKP;
	Tue, 20 May 2025 13:34:18 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHN6k-0000000D1lH-42GY
	for linux-nvme@lists.infradead.org;
	Tue, 20 May 2025 13:34:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 51B6668D1C; Tue, 20 May 2025 15:34:02 +0200 (CEST)
Date: Tue, 20 May 2025 15:34:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Christoph Hellwig <hch@lst.de>, Daniel Wagner <wagi@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: nvme-cli & json vs blktests
Message-ID: <20250520133401.GA7074@lst.de>
References: <20250519054905.GA6156@lst.de> <30a83f60-34eb-4940-b322-8ed31f091435@flourine.local> <20250519095642.GA21183@lst.de> <c8ea015a-8b60-4ffc-a706-f7eb5b65042c@flourine.local> <0362bd4f-4655-4f93-8023-945cacf31aba@nvidia.com> <a1e7dd62-b96b-4925-a9eb-d2cf181bd4f1@flourine.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1e7dd62-b96b-4925-a9eb-d2cf181bd4f1@flourine.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250520_063415_144736_82AA56EE 
X-CRM114-Status: GOOD (  11.22  )
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

On Tue, May 20, 2025 at 09:18:19AM +0200, Daniel Wagner wrote:
> I've updated the Makefile. The 'clean' target is now doing a proper
> cleanup and deletes all the build artifacts and configuration files.

Thanks!

