Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9E0ACA0FED
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Sep 2025 16:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZalyOnzjJWtFOs/1lDLt1aQU+rPm+9oNeC56NsNp26g=; b=W8WiNUkz0NhoYr9H9eMdWG/UaK
	7y9VRzkoguvOjfgy3X0mS/5O4SVYcYJzedqhlnnbrE7JfdlV7Ui/fCcGjq68G3STmwrv+QPP8lIOJ
	mDff46eV8QUSZgBB9d6g/o3Chw/yZeMVjs1ezcuiIuaLVjfGvIpVeiwnAeqgXwHDtSp6oTpnJ/ww2
	5Ap3czZjb0RVsP62Q/s9gdgmxK48bhvGSFpCDF+n4NC6YPFOqW+b4zGXe0mXIz0CKWYrPQ4NzYk8W
	mrbdDlBaCsNkFxRxaUF8DyaCCafPG5eTnSXaoppxiqXZNKCH+3r22crTOFEoGi4IwNlJyCiDMbxef
	x+Tm6mDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuZbI-00000003DsT-27Dp;
	Fri, 05 Sep 2025 16:47:48 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuWPb-00000001wnB-3FU1
	for linux-nvme@lists.infradead.org;
	Fri, 05 Sep 2025 13:23:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0C1CD60280;
	Fri,  5 Sep 2025 13:23:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0AB0C4CEF1;
	Fri,  5 Sep 2025 13:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757078610;
	bh=oUjxRpw2jn9nJg4SkZzc7uIiTF1l3VGO8gkEdXpUbwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nyrvac0H+l/lHSAlPh6QaASvjPJZFk5ehuYmjHV81YNgiOdZRzqaHBtXEMZ7bpkxn
	 8gAikwOkfU1qGvBUgbfnvg0T5EjGKYgkNv2Vdi8huubZ6MCLzjlmpCcageKcwPc3a8
	 QoSV/Ko9nVw/VbjlWVNz2waYMofB/byZgumufIz7SETHDJoM/NcScPstvoBSxGvWXf
	 +gp/fImF6E1/lRREo0EWyJ54+sxPAlJEiCMb/YuimLzA6w1OnpXc5tVFpD6gXwv55q
	 RdajGLUwKCtvsqudezvh9U6UxZgL57D5KD9zj+mbfwI5DtH/m1zqNXA/nw+NzBjHAI
	 0Lcd8j6DtIvxg==
Date: Fri, 5 Sep 2025 14:23:25 +0100
From: Simon Horman <horms@kernel.org>
To: alistair23@gmail.com
Cc: chuck.lever@oracle.com, hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
	kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v2 5/7] net/handshake: Support KeyUpdate message types
Message-ID: <20250905132325.GF553991@horms.kernel.org>
References: <20250905024659.811386-1-alistair.francis@wdc.com>
 <20250905024659.811386-6-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905024659.811386-6-alistair.francis@wdc.com>
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

On Fri, Sep 05, 2025 at 12:46:57PM +1000, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> When reporting the msg-type to userspace let's also support reporting
> KeyUpdate events. This supports reporting a client/server event and if
> the other side requested a KeyUpdateRequest.
> 
> Link: https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

...

> diff --git a/Documentation/netlink/specs/handshake.yaml b/Documentation/netlink/specs/handshake.yaml
> index a273bc74d26f..1a3312fad410 100644
> --- a/Documentation/netlink/specs/handshake.yaml
> +++ b/Documentation/netlink/specs/handshake.yaml
> @@ -21,12 +21,17 @@ definitions:
>      type: enum
>      name: msg-type
>      value-start: 0
> -    entries: [unspec, clienthello, serverhello]
> +    entries: [unspec, clienthello, serverhello, clientkeyupdate, clientkeyupdaterequest, serverkeyupdate, serverkeyupdaterequest]
>    -

This line seems excessively long.
The preference is for lines no longer than 80 characters wide.

Flagged by yamllint.

...

> diff --git a/net/handshake/tlshd.c b/net/handshake/tlshd.c

...

> @@ -348,7 +361,8 @@ EXPORT_SYMBOL(tls_client_hello_x509);
>   *   %-ESRCH: No user agent is available
>   *   %-ENOMEM: Memory allocation failed
>   */

Please also add keyupdate to the Kernel doc for this function.

Flagged by ./scripts/kernel-doc --none

> -int tls_client_hello_psk(const struct tls_handshake_args *args, gfp_t flags)
> +int tls_client_hello_psk(const struct tls_handshake_args *args, gfp_t flags,
> +			 handshake_key_update_type keyupdate)
>  {
>  	struct tls_handshake_req *treq;
>  	struct handshake_req *req;

...

> @@ -410,7 +428,8 @@ EXPORT_SYMBOL(tls_server_hello_x509);
>   *   %-ESRCH: No user agent is available
>   *   %-ENOMEM: Memory allocation failed
>   */

Ditto.

> -int tls_server_hello_psk(const struct tls_handshake_args *args, gfp_t flags)
> +int tls_server_hello_psk(const struct tls_handshake_args *args, gfp_t flags,
> +			 handshake_key_update_type keyupdate)
>  {
>  	struct tls_handshake_req *treq;
>  	struct handshake_req *req;

...

