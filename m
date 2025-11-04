Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B3ACCF9F8
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Nov 2025 00:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PYL76Eo021/f1pGLkIxMdeiGLR+ctmvVd5W8NoKHxkE=; b=WIRpqpGBdhheJx9Qpx+7Ehi+qD
	VtEjEGCpMRtnifSGjqaufTo2C0AUC07J0n8Cn0gefpsDbPmttd9pl3sQlhGs7hRnHQ2jvrmY7Wgc2
	b4F+afPNVBGSF9QsXERTghqoexmo7QLMKE6WfmjE2iqngrech4JCaAl/dM5tfvdllJ6NWsgVY2j3C
	FI4UCFOtT+pAtNOhzk91cKXXFlvEjIUp3gktBXtDbuisO+RkLA/neRf5kWEkpHLBIfAp+Rix5lUOx
	QEx4ATSdrbmH6GDFtlheLMplceHR5laWqRHGGXuj/THnqkOaipFYPpA5daCHZsqHIc5iF7Y7y2Ste
	zOSKW41Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG4sK-0000000AqW5-0Clf;
	Tue, 04 Nov 2025 00:26:16 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG4sF-0000000AqVP-0WPA
	for linux-nvme@lists.infradead.org;
	Tue, 04 Nov 2025 00:26:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1A2564444A;
	Tue,  4 Nov 2025 00:26:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFFC8C4CEE7;
	Tue,  4 Nov 2025 00:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762215970;
	bh=Bs1E/iPbvREfZ+wf8shPmjiAN3iesDcEtsodNw/AwWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j4/kFgYQyFL8sTyk7xpOQp2z2YsNUBecgSfSylcMCi/3dUT+HDBIST6uVMU23TWlX
	 KxhfKD1lYoMVfrdmHHRIg0sERPGSHaj1Zuz2v0RRxrOs0o+InX9nf0fjsrzIWRr6DG
	 5tuCNY1sPvfKKz+uvIKhYw7lyPLAc0bnyREwKnFnkWgxf+a3HynnM/pcOdxqJelxLN
	 RPsw/XqHAqk6qpyzih/jksClk8Ug2nqG30G0D5Vk5agdprcGUmIpVC3KwjqfOCNyEg
	 YADl0S+ZFC/3XkEvujfmmuqMIwGyW3kXajUxXzp9O+4rszoU6yevB2my+/a8/4r20o
	 Q/AVSaeVUCgVQ==
Date: Mon, 3 Nov 2025 19:26:08 -0500
From: Sasha Levin <sashal@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: patches@lists.linux.dev, stable@vger.kernel.org,
	Daniel Wagner <wagi@kernel.org>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
	justin.tee@broadcom.com, nareshgottumukkala83@gmail.com,
	paul.ely@broadcom.com, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 6.17-5.15] nvmet-fc: avoid scheduling association
 deletion twice
Message-ID: <aQlIII1UWi6FcYOz@laps>
References: <20251009155752.773732-1-sashal@kernel.org>
 <20251009155752.773732-15-sashal@kernel.org>
 <8bed9f7a-ad84-40e8-a275-09b19a917155@flourine.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <8bed9f7a-ad84-40e8-a275-09b19a917155@flourine.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251103_162611_204974_2E35C959 
X-CRM114-Status: GOOD (  15.85  )
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

On Fri, Oct 10, 2025 at 09:39:05AM +0200, Daniel Wagner wrote:
>Hi Sasha,
>
>On Thu, Oct 09, 2025 at 11:54:41AM -0400, Sasha Levin wrote:
>> From: Daniel Wagner <wagi@kernel.org>
>>
>> [ Upstream commit f2537be4f8421f6495edfa0bc284d722f253841d ]
>>
>> When forcefully shutting down a port via the configfs interface,
>> nvmet_port_subsys_drop_link() first calls nvmet_port_del_ctrls() and
>> then nvmet_disable_port(). Both functions will eventually schedule all
>> remaining associations for deletion.
>>
>> The current implementation checks whether an association is about to be
>> removed, but only after the work item has already been scheduled. As a
>> result, it is possible for the first scheduled work item to free all
>> resources, and then for the same work item to be scheduled again for
>> deletion.
>>
>> Because the association list is an RCU list, it is not possible to take
>> a lock and remove the list entry directly, so it cannot be looked up
>> again. Instead, a flag (terminating) must be used to determine whether
>> the association is already in the process of being deleted.
>>
>> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>> Closes: https://lore.kernel.org/all/rsdinhafrtlguauhesmrrzkybpnvwantwmyfq2ih5aregghax5@mhr7v3eryci3/
>> Reviewed-by: Hannes Reinecke <hare@suse.de>
>> Signed-off-by: Daniel Wagner <wagi@kernel.org>
>> Signed-off-by: Keith Busch <kbusch@kernel.org>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>This patch is part of a whole series:
>
>https://lore.kernel.org/all/20250902-fix-nvmet-fc-v3-0-1ae1ecb798d8@kernel.org/
>
>IMO, all should all be backported:
>
>db5a5406fb7e nvmet-fc: move lsop put work to nvmet_fc_ls_req_op
>f2537be4f842 nvmet-fc: avoid scheduling association deletion twice
>10c165af35d2 nvmet-fcloop: call done callback even when remote port is gone
>891cdbb162cc nvme-fc: use lock accessing port_state and rport state

Ack, thanks!

-- 
Thanks,
Sasha

