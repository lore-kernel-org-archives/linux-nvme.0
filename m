Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F7CD2ED0A
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Apr 2026 14:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Uzd/E6Eko7AM4qqI6jIWGG8FYO8UWHwa8yfKs6qD5YA=; b=jbdTG8cYZHepPjNIIzcC9esIky
	9N9QQmn2Payb8PT7V1zw+58VGb/bf64xb0ImVs0FP5VuZjSAPyq8QpHs6k6GfVoJTIPl4KVXtyavX
	7h7rm3nA7/k//dObJQ0zSpVkTNJ9T7goWqYAh0ntwaSvsUE71r4cvV7HNjm86Et+VRt+uuOe2WvMZ
	XQkLH7D3oUaw0XoXqVpcMYSgSo1hdka6kosSaDQ9Qh7zkg8iU0pHbSXyrwmY7WCXG0V3WpSznuI/2
	GxYRTczT9+vkeQcdpm9ASGOhS6b9mCQ9YOL1piJm6ImCbltCssGR3xAwh7AlM6mrOQgURcs2sdKa+
	CyGw+SAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7wD1-0000000FNZ4-07LP;
	Wed, 01 Apr 2026 14:06:15 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7wCt-0000000FNY7-20Bp
	for linux-nvme@lists.infradead.org;
	Wed, 01 Apr 2026 14:06:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 53E2840A69;
	Wed,  1 Apr 2026 14:06:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC188C4CEF7;
	Wed,  1 Apr 2026 14:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775052366;
	bh=yPZR/QfiNtvPlVecn1wrafQRC6Xmsic8KPMe8lSat14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i7YtNQs+v8GMqNsMDwSIUy6kxvKsspw8HSP70oK8WpdHW9HXi68lke3aq5Ij4M+cd
	 mkM3ZYj2dCIFLWA34ZkSr7bGAhZW0jx+vf8V0Wpon2kdJvhYJJTBsP+EP0DcdqyS5W
	 R5NVIETO6Am3aY8xFGBLqxTaNZ5eQFuIbZU85tx5PpSHrslXzpACFtDHQ34hOgbsJT
	 E0WR1tHQcEjoZz7LcBm5H1J1Po5cywGkqca3CjkdIUxAUNbG3rle6Qu8TzPbyWuYXs
	 Dtw0jyoZtEFZCcM0c0472/lZc5sx7pfjhDJcvNmBtZAuknMRKTGGVXekL+oTOvwFTp
	 XpIgP7A8+hDMA==
From: Daniel Wagner <wagi@kernel.org>
To: linux-nvme@lists.infradead.org,
	Nilay Shroff <nilay@linux.ibm.com>
Cc: Daniel Wagner <wagi@kernel.org>,
	dwagner@suse.de,
	gjoyce@linux.ibm.com
Subject: Re: [PATCH 0/2] extend nvme show-topology tabular output
Date: Wed,  1 Apr 2026 16:05:57 +0200
Message-ID: <177505222300.145518.18174999979947287711.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331141215.3098243-1-nilay@linux.ibm.com>
References: <20260331141215.3098243-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260401_070607_544625_3B8C13F1 
X-CRM114-Status: GOOD (  10.15  )
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


On Tue, 31 Mar 2026 19:42:07 +0530, Nilay Shroff wrote:
> This patchset extends the tabular output of the "nvme show-topology"
> command.
> 
> Currently, the tabular output does not display controller information
> if a controller has no associated namespaces or paths. However, it is
> valid for a controller within a subsystem to have no namespaces or
> paths attached.
> 
> [...]

I've reformatted the argument list for the functions and dropped
redunant comments.

Applied, thanks!

[1/2] nvme-cli: extend show-topology tabular output for non-multipath subsys
      commit: cb7974bfd9a62a59134d696c5f38150bc9e306d
[2/2] nvme-cli: extend show-topology tabular output for multipath subsys
      commit: ce97b2d804c31b93fac006d5202f4c62271087f4

Best regards,
-- 
Daniel Wagner <wagi@kernel.org>

