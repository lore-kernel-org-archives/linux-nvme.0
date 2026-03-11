Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB20112588E
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Mar 2026 20:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x7ET1UAqc5Qc8/9IvaRNf3RginEBmqUhLSh3l0yMeCE=; b=E/wFhzK4FzShQwfyDeWUT0kYJi
	s98PWwLWFAK+gTMSoMCnbc2hVVOcqhSLMUiRliO+4IPejoT6trSm3GqfJA+J8fqxQ3Uca2JyuQ7mf
	ZUs4Q1LdHRSouoh4ZrALUtlegS56I1r9T8XDtuAsWwD1YPfwT+/7OucflBYbJIR6ubk5dEecnX7Nj
	Xr3RFXYJG6vxFB39QmodvzhqAHs0Wyjtmex4szAnP2IQTafUfDQ2Z0QvRFXtBz5iE606esnpBCXkU
	GY/EaFrsQq3wgBGLbGcmQZ0fZmmmYbb96J07/LPWBJ9E8qdZ16CsYPHgl+/5ivYOhaKnt9Z0Xaziv
	HolldOkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0Q2o-0000000CTDG-0K5v;
	Wed, 11 Mar 2026 20:20:38 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0Q2l-0000000CTCW-35Op
	for linux-nvme@lists.infradead.org;
	Wed, 11 Mar 2026 20:20:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 7082A40791;
	Wed, 11 Mar 2026 20:20:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9FD3C4CEF7;
	Wed, 11 Mar 2026 20:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773260434;
	bh=lVtsNba0SRIZChCM3VGua3sO4gb2IS2bKuFIj5W7TBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HLURtHUOgZnwleK+tM5+JD5fwMhvvud2rrmRGa44BAWFHQxoSdxu/q8cSSJd9wrLk
	 ytg0lD+w1HLyepUOluyjR6H/xhVa68jLSSEdFKkSzow5cWzp4fGmTXhfGcTPNO84fE
	 2kmn2wfOXGqH0XVe8xIdVzecBLaqZ4m2jpbUGcgWmLmnwTHv6sbsAVi+pt+ICyw221
	 2KOMHYWI2WBewa61CI96m21KpUAKTYSi4OjA2jG9+Io4wZC6G7OWKwg01qbr1S4wgO
	 VaU5sYdb7tb1MxDPnfxItP1trZQmO2bDvVWzYlBz7ySUWmqYmqVFY5YXTx0AdRUFsP
	 iKeLh2k9GqJiw==
Date: Wed, 11 Mar 2026 14:20:31 -0600
From: Keith Busch <kbusch@kernel.org>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: linux-nvme@lists.infradead.org, dwagner@suse.de, yjshin0438@gmail.com,
	hare@suse.de, sagi@grimberg.me, chaitanyak@nvidia.com,
	mlombard@arkamax.eu
Subject: Re: [PATCH 1/2] nvmet-tcp: propagate nvmet_tcp_build_pdu_iovec()
 errors to its callers
Message-ID: <abHOjxsH3uZlWNEu@kbusch-mbp>
References: <20260311160920.465209-1-mlombard@redhat.com>
 <20260311160920.465209-2-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311160920.465209-2-mlombard@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260311_132035_797143_96E7714C 
X-CRM114-Status: GOOD (  14.93  )
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

On Wed, Mar 11, 2026 at 05:09:19PM +0100, Maurizio Lombardi wrote:
> Currently, when nvmet_tcp_build_pdu_iovec() detects an out-of-bounds
> PDU length or offset, it triggers nvmet_tcp_fatal_error(cmd->queue)
> and returns early. However, because the function returns void, the
> callers are entirely unaware that a fatal error has occurred and
> that the cmd->recv_msg.msg_iter was left uninitialized.
> 
> Callers such as nvmet_tcp_handle_h2c_data_pdu() proceed to blindly
> overwrite the queue state with queue->rcv_state = NVMET_TCP_RECV_DATA
> Consequently, the socket receiving loop may attempt to read incoming
> network data into the uninitialized iterator.
> 
> Fix this by shifting the error handling responsibility to the callers.

This looks good to me. Just some minor comments below.

> +	ret = nvmet_tcp_build_pdu_iovec(cmd);
> +	if (unlikely(ret)) {
> +		pr_err("queue %d: failed to build PDU iovec", queue->idx);

Missing the '\n' in this print.

> @@ -1092,7 +1098,12 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
>  	if (nvmet_tcp_need_data_in(queue->cmd)) {
>  		if (nvmet_tcp_has_inline_data(queue->cmd)) {
>  			queue->rcv_state = NVMET_TCP_RECV_DATA;
> -			nvmet_tcp_build_pdu_iovec(queue->cmd);
> +			ret = nvmet_tcp_build_pdu_iovec(queue->cmd);
> +			if (unlikely(ret)) {
> +				pr_err("queue %d: failed to build PDU iovec\n",
> +					queue->idx);
> +				return ret;
> +			}
>  			return 0;

Minor nit here, you can squash the two rets into a single 'return ret;'.

