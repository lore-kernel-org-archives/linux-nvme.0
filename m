Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2C92C5B543
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Jun 2025 19:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Du090O6Dse+WJcC8vjJBo0cfc9eCb+hPTvxqrxXIaFw=; b=4FC1cKZZsvs9qf
	USe+Sf6YaO+5n8MewcGojoEtk8g8G2G2cvdiJ+8d8L0Ou86T/Qw+xlPGz+2uBn/W9H/MysNu20AEe
	c8jL+ueFZgOW9MI+ZiKui1UVWl1XvVy667mIb+qrWnCh2UONZNd2yn3LVbuCGHdS0aCOLeHOR6Toh
	8RzryUWkldcn9+1uMmraowM+Eba8KmLKSwCYeJDGsoYkMmBXwFL94O8DUO7Xtqv2C3X5EKcjw3t9L
	kx/8FAJJ6h0JF+Y1aahbutEs2rw6pxSjvesjzsaC60hxCEV7IrEN7XeZQDUHt/f5Jn6JvjwHxjEiR
	uIc2sQC1c59wafxj1UfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMuB5-0000000E86c-1CA9;
	Wed, 04 Jun 2025 19:53:35 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMuB1-0000000E858-30zF
	for linux-nvme@lists.infradead.org;
	Wed, 04 Jun 2025 19:53:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 9D39D4A46F;
	Wed,  4 Jun 2025 19:53:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEEE5C4CEE4;
	Wed,  4 Jun 2025 19:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749066810;
	bh=6SAVqw289jRcTcQ+PCiFQKMlpJilukYhNge2apyk/+I=;
	h=Date:Subject:To:Cc:References:From:Reply-To:In-Reply-To:From;
	b=aUee7+F+VVbFb88Y+zuXz53ah29uxU/8HSb3RpOHsN2DQOtp+vQSPXhub6o9Ki7Xi
	 ZabbZoTNumzuubufi1SPerZWVcxenWAo75fitcEUkEWI4TDVowNr78LX0C20rDYjB2
	 IlpNNcK7s5e9peptryVBghiubwhbwMdH0F/iq3AdwyO0RnjA82O3XFwAwGQ3IQSW/o
	 P+5DlQuCzULmDrY+s47xBwokZ9UDO0x5ScCHr5XxGUHn4izBuBYVr0rGAJE8HfGTLN
	 ntxhkvGJvcdBRbtDcgjjYeze7iDfknq95/gseMhxCIlY2g0vfRQpZuNTmcn756qImY
	 uiPKIenAXPnyw==
Message-ID: <2a5d123a-3c95-47dc-8306-df76bb2b077b@kernel.org>
Date: Wed, 4 Jun 2025 21:53:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/10] Read/Write with meta/integrity
To: Christoph Hellwig <hch@infradead.org>, Anuj Gupta <anuj20.g@samsung.com>,
 shinichiro.kawasaki@wdc.com, Luis Chamberlain <mcgrof@kernel.org>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
 martin.petersen@oracle.com, asml.silence@gmail.com, anuj1072538@gmail.com,
 brauner@kernel.org, jack@suse.cz, viro@zeniv.linux.org.uk,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, gost.dev@samsung.com,
 linux-scsi@vger.kernel.org, vishak.g@samsung.com,
 linux-fsdevel@vger.kernel.org
References: <CGME20241128113036epcas5p397ba228852b72fff671fe695c322a3ef@epcas5p3.samsung.com>
 <20241128112240.8867-1-anuj20.g@samsung.com> <aD_qN7pDeYXz10NU@infradead.org>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <aD_qN7pDeYXz10NU@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250604_125331_765829_ED4093BA 
X-CRM114-Status: GOOD (  15.37  )
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
Reply-To: da.gomez@kernel.org
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 04/06/2025 08.39, Christoph Hellwig wrote:
> On Thu, Nov 28, 2024 at 04:52:30PM +0530, Anuj Gupta wrote:
>> This adds a new io_uring interface to exchange additional integrity/pi
>> metadata with read/write.
>>
>> Example program for using the interface is appended below [1].
>>
>> The patchset is on top of block/for-next.
>>
>> Testing has been done by modifying fio:
>> https://github.com/SamsungDS/fio/tree/priv/feat/pi-test-v11
> 
> It looks like this never got into upstream fio.  Do you plan to submit
> it?  It would also be extremely useful to have a testing using it in
> blktests, because it seems like we don't have any test coverage for the
> read/write with metadata code at the moment.
> 
> Just bringing this up because I want to be able to properly test the
> metadata side of the nvme/block support for the new DMA mapping API
> and I'm ѕtruggling to come up with good test coverage.
> 

FWIW, we’re interested [1] in helping get this part properly tested as well.
We're already running blktests in CI as part of kdevops, regularly testing
against both linux-next and Linus' latest tags [2].

[1]
https://lore.kernel.org/all/Z9v-1xjl7dD7Tr-H@bombadil.infradead.org/

[2]
https://github.com/linux-kdevops/kdevops-ci/actions

Shin'ichiro, the current CI implementation is still experimental (we are missing
a few things like archive results and dashboard reporting) but we hope we can
discuss soon the possibility to automatically reporting tests results to the
mailing list

