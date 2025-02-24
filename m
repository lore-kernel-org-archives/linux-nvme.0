Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09912C021A4
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2025 22:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AO7vZwUX7g5LASH+jeef3svGuSXpEF1Sj/dGP6z1YQ8=; b=Ph1ZuSeY6q128gjRIenmVz84G7
	JLjpL8U54WoapcN7Hujpu/v3kh39VWyUou/WcFn5bmPhsVxW3BnSW3qQeKLKgzBYos7dlT8PA6Ew2
	KSUHUplklVWAvuX70a/KieJy6S+hX2eQShJb1YTnS+cywQTG+Fr2nyGsWvY28IY71R5Ys39uJVWNE
	zezXfbHu1NWY1onsijK/Qt/MdO1yAKo+rtC8EzkBJPEC2H0jftMiLLawtTsK0Ffl4kT3K9YBJ4ctc
	ESYSldKqZUju1dvIjUvHyYajnV2iHYO2jlCChfoJxd49ThUf+3ymEIO8whiw2zs1uaRpzwpgO/SKV
	5UC7iubw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmgqi-0000000FLvT-2SSW;
	Mon, 24 Feb 2025 22:22:52 +0000
Received: from tor.source.kernel.org ([2600:3c04::f03c:95ff:fe5e:7468])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmgqh-0000000FLv0-3fFb
	for linux-nvme@lists.infradead.org;
	Mon, 24 Feb 2025 22:22:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 22522611F6;
	Mon, 24 Feb 2025 22:22:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A5CAC4CED6;
	Mon, 24 Feb 2025 22:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740435770;
	bh=xzCjgK8smtrcY9LxROh/ezjTZ18hNMFYASOvBpCiD7o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jwDiVRlSoMFzEk2yedT5FnNnJJP/vqtbyymc9yyl2F/JCt6J6vrSZt+Wy9GmC9Sa4
	 VAzBncGanp67bd6JhD3r+ZHsTdTJ8JS131uKI7TnxOP5KO8GLtDGmOLWGZOd11AarI
	 3ySsvV/bSzIpM1Ic0uBMzJiu47f/H6rEBv1If8mOKI9O9EwBmBaUUKaZjuwCEqPnB/
	 0pXerEAUcQNqgZ8j0NNvxnmYHqzXgAv+TfY6Pu2mpUzttVK+GDMRy5rlD3QRzYrwIl
	 ImY2dx5NIXfsOrAKbIjRYkMGkwmV+FRlttQeiEg7kSju9V3o1d44qocqb4egzxO8UJ
	 Vv2gCV3HOttuQ==
Message-ID: <528e1820-1a98-4937-a3d0-4c959260c022@kernel.org>
Date: Tue, 25 Feb 2025 07:22:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] nvme-ioctl: use common type for user data addresses
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
 hch@lst.de, sagi@grimberg.me
Cc: Keith Busch <kbusch@kernel.org>
References: <20250224182128.2042061-1-kbusch@meta.com>
 <20250224182128.2042061-3-kbusch@meta.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250224182128.2042061-3-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 2/25/25 03:21, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The data type is represented as a u64, but the metadata type as a __user
> void *. These two fields represent the same thing, so treating them so
> differently looks a bit odd. Just pick one consistent type of
> representation.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Maybe mention that were needed nvme_to_user_ptr() to not lose the __user attribute ?

Otherwise, looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

