Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E07ECAAA1
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Oct 2022 14:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nX5gWGCrasWszwJYCvHTVCSeHjSFI5dz+SyVhC2o2n4=; b=vice5oxgw4sCWAlbz/OYfgldGI
	/E81e+48RBKKbxccb3gu9RZFDhswcZe0oWdoOSdRpq+KaqbQ9kepkDAE0MTqWGDXrYDzPblB3I+uN
	cFdGPF7Yl6NUboc32FKuTtiEzOVnERAYF22s9C+QMSkBkURu9NnNyctT2bN6Rm98+iQOLoY/MUNT4
	ifs176tLVHn/PIHS9BYFGd5TCiLAerMjOIKm20jVFFPX6VRoOcNuSzsGgA4dK9ijvjEr/BP8dWXO9
	6yGZUl4ZWm01cQU0VpcubWiDLUnWMJ/moPyBKHmkEuWgyoI7One3p+USVoJ5g59T7e8g1bYdBC7Kv
	hAyYOQIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooQkz-000IbK-0K; Fri, 28 Oct 2022 14:54:49 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooQiM-000HC9-4R
	for linux-nvme@lists.infradead.org; Fri, 28 Oct 2022 14:52:07 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 334F46289F;
	Fri, 28 Oct 2022 14:52:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0133DC433D6;
	Fri, 28 Oct 2022 14:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666968724;
	bh=eMzwYAZAzlCZqXn5EpY6pg239/+yDkyB9HkD9TyRmXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BmLkAQF87ThDLf9Nu/Z6b+L1XS0epmuDuVuUVj4mc7YH3oPJ5aQ4jzQ0kim+Dbkht
	 deJy5skrsa0b1/uoScx9kT59LqA1kyEKw/6ez1/gfSVPGqgNOEkmeqd4R6asxmyJQw
	 zGstWylr5yxgyKZywPz0oRCQGyby5XYmQB3QpzQ+GibJLvQmb/74SfRfktqIRKIcA3
	 TqDxP4OFZDVOE9WPNqCbBXfPt2OaNWRoUl2gEXcNFL7ro6vBKn6ZngTAx4+PWsoW4T
	 mg5eMs9GRykIx4dpZpYoHKB/RMp2CwMfMPnnXwczw/fTgKvHknlggZ9op1rAdOh0W7
	 OzrYcfElbbCsg==
Date: Fri, 28 Oct 2022 08:52:01 -0600
From: Keith Busch <kbusch@kernel.org>
To: Joel Granados <j.granados@samsung.com>
Cc: sagi@grimberg.me, hch@lst.de, linux-nvme@lists.infradead.org,
	gost.dev@samsung.com, joshi.k@samsung.com, javier.gonz@samsung.com,
	p.raghav@samsung.com
Subject: Re: [RFC 3/3] nvme : Add ioctl to query nvme attributes
Message-ID: <Y1vskd0uY308uSf4@kbusch-mbp.dhcp.thefacebook.com>
References: <20221027155724.1161670-1-j.granados@samsung.com>
 <CGME20221027160108eucas1p2722b30a1be27a855e2b0f2495fed15ab@eucas1p2.samsung.com>
 <20221027155724.1161670-4-j.granados@samsung.com>
 <Y1q4Cjg1cv9w+YWR@kbusch-mbp.dhcp.thefacebook.com>
 <20221028103827.o7uhl36qavkpx22d@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028103827.o7uhl36qavkpx22d@localhost>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221028_075206_266299_CF9F9E0A 
X-CRM114-Status: UNSURE (   8.55  )
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

On Fri, Oct 28, 2022 at 12:38:27PM +0200, Joel Granados wrote:
> 3. And the variables that are not in struct nvme_ctrl. Here, we have not
>    option but to make an IO.

You do have another option: we have historically added new fields to
nvme_ctrl to cache parameters that are repeatedly referenced in other
contexts, and this usage appears to qualify.

