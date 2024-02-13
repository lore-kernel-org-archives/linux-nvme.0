Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 028CCC48260
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Feb 2024 10:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xNmHZJiVZBNfWNIXD4xQ6Nh+GfJTXGoOsqH/dDyQMWg=; b=3Ylt6ziLkuMjyd6wbDWTJEtK6W
	Qjp0S7+t49uva0yB4upjgJ609q7cjxkXYQEiCCXBSnFoEb/LwycuCI+YsHoRFDW3Q1ezaVLSBa9bN
	HMvZrR4Wj63gCJ/uaEIkFJLLvY16lC9Cppp0RBGMxZtXfYubZt0hRA4Xwv24Emiqrxfp6enPK7XwV
	Gu8xqqnXuThPIHj3KEKkczu7GQfq0R/19RporxCxpd6XnqVtS/RJgSvFIzIB/uBXt9nMKeZ+hhcdf
	0aFAZkiAHIbCr93X2JyOtFgSHhg5nBzU64ZXSC0aWFEKAAQKBx96C39r2AVDZeMKuYbiamwK5+g8S
	s6reuTfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZq5I-00000008qDh-3AYe;
	Tue, 13 Feb 2024 10:32:16 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZq5E-00000008qBY-0f4s
	for linux-nvme@lists.infradead.org;
	Tue, 13 Feb 2024 10:32:14 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CDFE21FC81;
	Tue, 13 Feb 2024 10:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707820328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xNmHZJiVZBNfWNIXD4xQ6Nh+GfJTXGoOsqH/dDyQMWg=;
	b=ENx0BGyvS5z823pLFqaxMwPXbdB/3olVpTDfSpTPMGe+hfoU3YKooj3Yo7CiX1Sa7tnZdr
	QF6vO07ZeADwEZB7PXxIHC1ciw9lCGWNge8+SuW8OL1/sN+JZK93krMfxsJAFBSBXWjY1m
	6NjhuGirdYJPwEC8RsxEZuWyIM+ajwQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707820328;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xNmHZJiVZBNfWNIXD4xQ6Nh+GfJTXGoOsqH/dDyQMWg=;
	b=rcSoWqoV+xAZr0v1DgA5gD10dzX14FN2aExro7Fmc0/B/Tn9UnzFL9CaK1Xr86vBXP+PlM
	Fe7sLapqMzHHEoDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707820327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xNmHZJiVZBNfWNIXD4xQ6Nh+GfJTXGoOsqH/dDyQMWg=;
	b=iOU5fQyGuxjmtmAsG461BJj1Xvgb2LACCoWLwacMCYKJ5rfs8KryJkd2UTHdyXzOI4zIXo
	Y3Ma9g7QU/SxcrZqT3nYNoLABbpmzRNEvXpwuknEP8P2ekc3ywaYZGUmxlNrcsrUwirqNM
	TDs4DgxNhPXPI/g43drMLkOzV8NzDB8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707820327;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xNmHZJiVZBNfWNIXD4xQ6Nh+GfJTXGoOsqH/dDyQMWg=;
	b=fu5nJFtDgXCdlJfkM8/YdrYi6RT/w/OxKmK+U+4j+s+RICNdp2gF3f83GMxbyJlakqxuXa
	URaMSIjx9pbRdpCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B95F113404;
	Tue, 13 Feb 2024 10:32:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GbSyLCdFy2UDagAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 13 Feb 2024 10:32:07 +0000
Message-ID: <4f2409b7-9854-4f86-80b6-b676a694d3e8@suse.de>
Date: Tue, 13 Feb 2024 11:32:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-fabrics: fix I/O connect error handling
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
References: <20240208113125.50498-1-kch@nvidia.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240208113125.50498-1-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=iOU5fQyG;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fu5nJFtD
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.50 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[5];
	 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,nvidia.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Queue-Id: CDFE21FC81
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240213_023212_406356_26C17249 
X-CRM114-Status: GOOD (  17.81  )
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

On 2/8/24 12:31, Chaitanya Kulkarni wrote:
> In nvmf_connect_io_queue(), if connect I/O command fails, we log the
> error and continue for authentication. This overrides error captured
> from __nvme_submit_sync_cmd(), causing wrong return value.
> 
> Add goto out_free_data after logging connect error to fix the issue.
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
> 
> blktests is passing with this patch :-
> 
> blktests (master) # ./check nvme
> nvme/002 (create many subsystems and test discovery)         [passed]
>      runtime  24.281s  ...  24.481s
> nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
>      runtime  11.262s  ...  11.275s
> nvme/004 (test nvme and nvmet UUID NS descriptors)           [passed]
>      runtime  0.492s  ...  0.496s
> nvme/005 (reset local loopback target)                       [passed]
>      runtime  0.810s  ...  0.807s
> nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
>      runtime  0.093s  ...  0.091s
> nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
>      runtime  0.063s  ...  0.064s
> nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
>      runtime  0.490s  ...  0.491s
> nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
>      runtime  0.478s  ...  0.466s
> nvme/010 (run data verification fio job on NVMeOF block device-backed ns) [passed]
>      runtime  51.736s  ...  41.236s
> nvme/011 (run data verification fio job on NVMeOF file-backed ns) [passed]
>      runtime  203.890s  ...  141.790s
> nvme/012 (run mkfs and data verification fio job on NVMeOF block device-backed ns) [passed]
>      runtime  45.403s  ...  33.713s
> nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed ns) [passed]
>      runtime  113.799s  ...  119.578s
> nvme/014 (flush a NVMeOF block device-backed ns)             [passed]
>      runtime  8.669s  ...  8.488s
> nvme/015 (unit test for NVMe flush for file backed ns)       [passed]
>      runtime  7.303s  ...  6.619s
> nvme/016 (create/delete many NVMeOF block device-backed ns and test discovery) [passed]
>      runtime  12.945s  ...  13.004s
> nvme/017 (create/delete many file-ns and test discovery)     [passed]
>      runtime  14.377s  ...  14.490s
> nvme/018 (unit test NVMe-oF out of range access on a file backend) [passed]
>      runtime  0.491s  ...  0.472s
> nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
>      runtime  0.488s  ...  0.505s
> nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
>      runtime  0.502s  ...  0.472s
> nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
>      runtime  0.472s  ...  0.499s
> nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]
>      runtime  0.802s  ...  0.812s
> nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
>      runtime  0.505s  ...  0.488s
> nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
>      runtime  0.474s  ...  0.481s
> nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
>      runtime  0.484s  ...  0.470s
> nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
>      runtime  0.482s  ...  0.479s
> nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
>      runtime  0.473s  ...  0.493s
> nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
>      runtime  0.492s  ...  0.474s
> nvme/029 (test userspace IO via nvme-cli read/write interface) [passed]
>      runtime  0.671s  ...  0.667s
> nvme/030 (ensure the discovery generation counter is updated appropriately) [passed]
>      runtime  0.244s  ...  0.241s
> nvme/031 (test deletion of NVMeOF controllers immediately after setup) [passed]
>      runtime  4.329s  ...  4.257s
> nvme/038 (test deletion of NVMeOF subsystem without enabling) [passed]
>      runtime  0.019s  ...  0.020s
> nvme/040 (test nvme fabrics controller reset/disconnect operation during I/O) [passed]
>      runtime  7.225s  ...  7.154s
> nvme/041 (Create authenticated connections)                  [passed]
>      runtime  1.946s  ...  1.938s
> nvme/042 (Test dhchap key types for authenticated connections) [passed]
>      runtime  5.804s  ...  5.733s
> nvme/043 (Test hash and DH group variations for authenticated connections) [passed]
>      runtime  25.909s  ...  21.684s
> nvme/044 (Test bi-directional authentication)                [passed]
>      runtime  4.080s  ...  4.091s
> nvme/045 (Test re-authentication)                            [passed]
>      runtime  2.213s  ...  1.706s
> nvme/047 (test different queue types for fabric transports)  [not run]
>      nvme_trtype=loop is not supported in this test
> nvme/048 (Test queue count changes on reconnect)             [not run]
>      nvme_trtype=loop is not supported in this test
> blktests (master) #
> 
>   drivers/nvme/host/fabrics.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 3499acbf6a82..495c171daead 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -534,6 +534,7 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
>   	if (ret) {
>   		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(res.u32),
>   				       &cmd, data);
> +		goto out_free_data;
>   	}
>   	result = le32_to_cpu(res.u32);
>   	if (result & (NVME_CONNECT_AUTHREQ_ATR | NVME_CONNECT_AUTHREQ_ASCR)) {

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes


