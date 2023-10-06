Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B6AE81DE9
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Oct 2023 12:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k8v2EFpF8HyNHuws9xn1C1NszHsygabYOlbE0VQUixk=; b=WMp4QpdNcHKiotYPAF8WFD2GRp
	wErj9UY72EiIfVJ+YEQfF5Z7uQt9zQefLgXDSds+9uA7xEu4/Z6ZV0njCrpmgtoi9XLF1omqXYzI1
	PR3Ee2QyRM24egPO8VkDzzokP2CzQunSXHmDngIyBqB/7rHEjDhB5RiTNCB0y3BAtszGSpDtd4K/F
	b4bndnpAHJHc2MNo2LnZGXprxBMMYbNVDbS72h0qJgyy//yQX2Wu2P6i5ASn2EiqWE59UghemG9dj
	Owmn/biU3h6Aiu06FAO9HgkUamG1WhVj0acZpYAI/H+tQ2XrPP7091SBC/OTj3/4UblizIDydR78u
	FuGcWXoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qojpO-005lat-0o;
	Fri, 06 Oct 2023 12:21:10 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qojpL-005laD-0M
	for linux-nvme@lists.infradead.org;
	Fri, 06 Oct 2023 12:21:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 36321B828F7;
	Fri,  6 Oct 2023 12:21:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62803C433C8;
	Fri,  6 Oct 2023 12:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696594864;
	bh=eEAGMHnLPIv/m3ngBpVNSfrVjCGlhTK1953WUjSor24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bTXbTRgNaMfuCwMIoA/eYL/Ty2cOHyVRkujckTVIVasdng3pdpgrF5iCuClH+EUSZ
	 H10CTbO4yMuEIY5W+wYDXPHgfwcU96fYY6TOdxEo4bUm3dkM0rtwbc5OKECSdesUUl
	 9QWWmlTX4Uz0C5qxd4RyhDOibmyK2L3kI5hSbPr/U5jVFxDt2VflX/pNiVuZaJcNrA
	 Qc+/vQIM/x4SplFOUOV6Y++ujNO7WYs4Dg60vWukRQutYUIIFLpvLc/h31vPcysN04
	 S8HAWiT/vaz35WwZFYo1xTmxvf8jYJqDkmTfxm+hGzHYQ87y6WpR8mtaZ/ohB6wH8n
	 0KaRBx8WLSsCw==
Date: Fri, 6 Oct 2023 08:21:03 -0400
From: Sasha Levin <sashal@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Greg KH <gregkh@linuxfoundation.org>, sj@kernel.org,
	linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	zahavi.alon@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH] nvmet-tcp: Fix a possible UAF in queue intialization
 setup
Message-ID: <ZR_7rzhMCkKAUN_x@sashalap>
References: <20231003164638.2526-1-sj@kernel.org>
 <1ed79a61-0e74-7264-cb70-c65531cf60e2@grimberg.me>
 <2023100445-twisted-everyone-be72@gregkh>
 <01901640-fc6d-5d15-3aa0-9f4586ba5141@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <01901640-fc6d-5d15-3aa0-9f4586ba5141@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231006_052107_301434_E02E185E 
X-CRM114-Status: GOOD (  17.08  )
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

On Wed, Oct 04, 2023 at 04:25:13PM +0300, Sagi Grimberg wrote:
>
>>>>Hello,
>>>>
>>>>On Mon, 2 Oct 2023 13:54:28 +0300 Sagi Grimberg <sagi@grimberg.me> wrote:
>>>>
>>>>>  From Alon:
>>>>>"Due to a logical bug in the NVMe-oF/TCP subsystem in the Linux kernel,
>>>>>a malicious user can cause a UAF and a double free, which may lead to
>>>>>RCE (may also lead to an LPE in case the attacker already has local
>>>>>privileges)."
>>>>>
>>>>>Hence, when a queue initialization fails after the ahash requests are
>>>>>allocated, it is guaranteed that the queue removal async work will be
>>>>>called, hence leave the deallocation to the queue removal.
>>>>>
>>>>>Also, be extra careful not to continue processing the socket, so set
>>>>>queue rcv_state to NVMET_TCP_RECV_ERR upon a socket error.
>>>>>
>>>>>Reported-by: Alon Zahavi <zahavi.alon@gmail.com>
>>>>>Tested-by: Alon Zahavi <zahavi.alon@gmail.com>
>>>>>Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>>>>
>>>>Would it be better to add Fixes: and Cc: stable lines?
>>>
>>>This issue existed since the introduction of the driver, I am not sure
>>>it applies cleanly that far back...
>>>
>>>I figured that the description and Reported-by tag will trigger stable
>>>kernel pick up...
>>
>><formletter>
>>
>>This is not the correct way to submit patches for inclusion in the
>>stable kernel tree.  Please read:
>>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
>>for how to do this properly.
>>
>></formletter>
>
>I could have sworn to have seen patches that did not have stable CCd
>nor a Fixes tag and was picked up for stable kernels :)
>But I guess those were either hallucinations or someone sending patches
>to stable...

That happens, but there are no guarantees around it.

If you really want for a patch to land in stable, and want to know if
for some reason it didn't, the only way to do it is with an explicit
stable tag. Otherwise it's just "best effort".

-- 
Thanks,
Sasha

