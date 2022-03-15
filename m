Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A41C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Mar 2022 09:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZrW6PdXfHl+VF3ydtj2u38kVmWWJ4mSFlEFavrLpN/s=; b=EoIT56CvxHHUA1nkOuPYaB05Tr
	/ogf5Jc4XhKFzOlmSCjn9NaC+ooLbmzcsBtIWckqYZw6WeUYlWWJxX6tZplf6bVLQhjZA6IBboqIg
	kDGHbGkI5xY/lLh0dg5B0rLEBdmy/yxA7uoqgpC8V/IcctmlDJjPG2RGwHVnJ5HvJ9HrRLcafCnRY
	OGdR5xX3QPDm9Ks+nIfArq4qE+jQrIoHs6FFj0rlaDBvY7faV+r3MkQBdg8kUt4As3nK9JrElGsf4
	FJtW7BtKvz2AtPqalDaFTQb127OrTBDD0o5SZ9EEuqjywAZqJlrJxHxT5bSl3VlwIy2blOrcMAfyE
	9iszleDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nU32i-008P4i-VF; Tue, 15 Mar 2022 09:00:36 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nU32g-008P3V-Jb
 for linux-nvme@lists.infradead.org; Tue, 15 Mar 2022 09:00:35 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7FDD168AA6; Tue, 15 Mar 2022 10:00:30 +0100 (CET)
Date: Tue, 15 Mar 2022 10:00:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/3] nvmet: restrict setting of discovery_nqn to
 discovery subsystem
Message-ID: <20220315090030.GA4321@lst.de>
References: <20220314105333.56714-1-hare@suse.de>
 <20220314105333.56714-3-hare@suse.de> <20220315080908.GB3082@lst.de>
 <42045e78-dce4-2653-e882-46c48cc6e64e@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42045e78-dce4-2653-e882-46c48cc6e64e@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220315_020034_814170_3DB5A116 
X-CRM114-Status: GOOD (  12.21  )
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

On Tue, Mar 15, 2022 at 10:57:35AM +0200, Sagi Grimberg wrote:
>> It is a fairly recent addition by you and without nvmetcli support, so
>> maybe we can revert this entire attribute to redo discovery controller
>> handling, but as-is this patch seems rather broken.
>
> I think we could, I doubt anyone uses this interface at this point...

Then please send a revert for "nvmet: make discovery NQN configurable"
against the 5.17 tree ASAP.  That way it will only be in 5.16.

