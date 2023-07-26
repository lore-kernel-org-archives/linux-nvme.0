Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8562AC001B0
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jul 2023 13:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LSQ73LbKUMHeAGS7L35HoIpYbosZ2A1+p8R+9oAIUj8=; b=Z9DAI8chvM0hOqOkWg27PjT7AS
	qKfNvyxhxjTmI7aQF0U+V1y9riCFQurMbg7LBXule8ycal/JFew44WT59tuhfX5RSdJfNht6v4dtq
	4mycfEUMVgjNX8oChathKh71mzuAL1e5IhPWpfllEaTIh7mIF6sv5HMB+Q21CDmD7UIiiAkAPNxuT
	1ypqfRSrYkiUE7o3u4gLyr/MYt/KpVfzewsx51PE3KzpfSZK9JaK8B7/OiDIWFmEeB9Ceo/Y6dKUg
	QNT+ns3VllR5jnG/cu+ThdktDRYEvMyLhesdGLI5qLVIQkB4dawXlLlLqdCU+x72aU4LyKW88/KFQ
	MqxRY82w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qOeIv-00AV4L-00;
	Wed, 26 Jul 2023 13:11:49 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qOeIu-00AV44-0H;
	Wed, 26 Jul 2023 13:11:48 +0000
Date: Wed, 26 Jul 2023 06:11:48 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v1 1/2] nvme: drop multipath config option
Message-ID: <ZMEblNUKKKz+XvPX@infradead.org>
References: <20230719084147.16272-1-dwagner@suse.de>
 <20230719084147.16272-2-dwagner@suse.de>
 <ZLe1QmfGg488wH9D@kbusch-mbp.dhcp.thefacebook.com>
 <ZL6sFA+fwsWwWOkF@infradead.org>
 <7risd4kfoey3mkwsjr2hd5ofxawvjenjv6h4x76p6gepzoygll@cwap52i6hwg2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7risd4kfoey3mkwsjr2hd5ofxawvjenjv6h4x76p6gepzoygll@cwap52i6hwg2>
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

On Tue, Jul 25, 2023 at 08:05:25AM +0200, Daniel Wagner wrote:
> On Mon, Jul 24, 2023 at 09:51:32AM -0700, Christoph Hellwig wrote:
> > Btw, Daniel - any reason you didn't Cc me on this?
> 
> I thought you preferred not to be Cc. I am just trying to be nice :)

Heh.  I usually try to avoid being Cced by the crazy get_maintainer
heuristics, because that means I get Cced on everything.  For
things I maintain the Cc really helps getting my attention when
I'm overscheduled like now and might be way behind on the lists.

