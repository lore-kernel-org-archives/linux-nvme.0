Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 034E8C433F5
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Feb 2022 07:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g7slLVHtlyV5QjZ1gASo7jmHejiK6sDvrnzOeGYRg0o=; b=ZbW9hOLSdUQMYqTMMIkc3EgERs
	bLers9ZV7DWBjVI6cCp5RF7lQ3QBHEZdppT/Vct6nydJ79e1jprmNKAe3GG0Qgtn+uCJt0LjxtU3M
	BPgtOYnhZVMzpDLqnWlaUwnvFTVOfQF1sEOp4UuosyYGC5pVPuFp+4cSa90coQBdaI0DSVOX8/9EX
	kswTf/69n5gWzCfgciAoAAeljy572ZDxga2gjIe0Lt/VZwEUoIDaCYt4QZDqw42IfFjJ/it9xwNor
	KdcmBpAXx8rC6haLhHTgxdb+cw/0JN+wbE056y98UF7YscOMtVzooEIfZ7KG1AAWWyn/zM+bby/LV
	upWsL9yg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFtI5-003gwz-9K; Fri, 04 Feb 2022 07:45:57 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFtI2-003gwD-BV
 for linux-nvme@lists.infradead.org; Fri, 04 Feb 2022 07:45:55 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 146FBB836BA;
 Fri,  4 Feb 2022 07:45:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0150BC004E1;
 Fri,  4 Feb 2022 07:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1643960751;
 bh=1PuijvRB130X8lf3r7DTvjrIX6oIyc56/q82XxvAR2A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=a2o6eQ4YIGMrGkIazgHLAEmDBKxgqDUXXmfO57bE6LZ96cqj1YVbMya5GrOYxkDoV
 eAwH0rwmou1sm0vMP3UZDo/ibSXkJOFzmwcGRxYJZjDwSn/8mDq83biJyr9nDxXhzw
 yhyOzA3u9POYded+5CtXlhKD+00/PLNV+zdhV36A=
Date: Fri, 4 Feb 2022 08:45:43 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Martin Belanger <nitram_67@hotmail.com>, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, hare@suse.de, axboe@fb.com, sagi@grimberg.me,
 rafael@kernel.org, charles_rose@dell.com, stuart_hayes@dell.com,
 Martin Belanger <martin.belanger@dell.com>
Subject: Re: driver core patch, was Re: [PATCHv2 2/3] nvme: Add
 device_update_groups()
Message-ID: <YfzZp5KeuMUve99Q@kroah.com>
References: <20220203211748.27542-1-nitram_67@hotmail.com>
 <BL0PR13MB42916EA4483338B4BD37BA3E9C289@BL0PR13MB4291.namprd13.prod.outlook.com>
 <20220204070441.GA28558@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204070441.GA28558@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220203_234554_557385_70EFD898 
X-CRM114-Status: GOOD (  13.47  )
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

On Fri, Feb 04, 2022 at 08:04:41AM +0100, Christoph Hellwig wrote:
> On Thu, Feb 03, 2022 at 04:17:47PM -0500, Martin Belanger wrote:
> > From: Martin Belanger <martin.belanger@dell.com>
> > 
> > This is used to update the sysfs groups after device objects are fully
> > initialized.
> > 
> > Signed-off-by: Martin Belanger <martin.belanger@dell.com>
> 
> This isn't a nvme patch, but a driver model one.  Adjusting the subject
> to bring it to Gregs attention.

Thanks for that, now NAKed :)

