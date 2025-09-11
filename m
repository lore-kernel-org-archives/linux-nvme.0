Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F9BCAC587
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Sep 2025 18:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VG7BNNjb9esAXsIUOXmy+HZgEg4C79t63E7EKVNJ7M0=; b=f0FwO2BaaLQuvRpxPeELTPgYgl
	B3lic54FA/3T96nwYyefAHcvRnUqvt7jq47EYbAUzv42XEYuTShfK4b/ycyuLKSE+8uiB3CtBPVps
	Y8pnIGLm78AIyDYOP58sQfP2xBkW5XuRJ6A6EQoyGjDMLNfDBDHB7TTbiflMkSz4s5Kg1jqyaS0+e
	ye/sHPirDCRzZXZR0aLfDHYdpxqgfpL4JawAiJO3cGM47+L/deiKiXTnFUUepVPcUkMZWCbXmYJ2n
	kVvRZHjJfTMfygKRBw9gmb3ewq4urVkiiUEXNZ0yFeRGxWv1/2C0+LPEUokHnlCJzaL76OYF0acSR
	51WS2K0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwmLN-00000004pi0-0rxY;
	Thu, 11 Sep 2025 18:48:29 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwmLL-00000004phu-3V0c
	for linux-nvme@lists.infradead.org;
	Thu, 11 Sep 2025 18:48:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 2F1EA6022C;
	Thu, 11 Sep 2025 18:48:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59500C4CEF0;
	Thu, 11 Sep 2025 18:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757616506;
	bh=H8UUZOCJhz1KPH1y8ZlpmxMWu4oKmdFcyuOQUpaI34U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eGb+0Be7x0x2MrgZS7iOKqb5O54rXDuJziKq17eARe44Xax1DD62wgxvA+y2vdrjp
	 Dh+h6UI9HghSBHF1jFiFWFd8QBk5IrIL+RumjHo7/ByFad3/IrzdMff6fnJav/fv3z
	 tPNqq7BdZQ/7/SKngHj8xJkucqj1ZHvDbu7NRqvBwfaNk7snbjRSoi6p9jJls6I4F6
	 JvrmMfLHR6LRHn9Ph+wm8w+TaSgBu2B8FT51TuaFSlz4BbRk4aOGHFF9o0NhfBW48A
	 wWXSevMFTzJwka7NEboPEZc7xlT06QfHduCAf7+E8TKaYCnWEVIR7yoq1p2wFMPn1u
	 bxgFDk9gzm0SA==
Date: Thu, 11 Sep 2025 11:47:05 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Guan-Chun Wu <409411716@gms.tku.edu.tw>
Cc: akpm@linux-foundation.org, axboe@kernel.dk, ceph-devel@vger.kernel.org,
	hch@lst.de, home7438072@gmail.com, idryomov@gmail.com,
	jaegeuk@kernel.org, kbusch@kernel.org,
	linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, sagi@grimberg.me, tytso@mit.edu,
	visitorckw@gmail.com, xiubli@redhat.com
Subject: Re: [PATCH v2 4/5] fscrypt: replace local base64url helpers with
 generic lib/base64 helpers
Message-ID: <20250911184705.GD1376@sol>
References: <20250911072925.547163-1-409411716@gms.tku.edu.tw>
 <20250911074556.691401-1-409411716@gms.tku.edu.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911074556.691401-1-409411716@gms.tku.edu.tw>
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

On Thu, Sep 11, 2025 at 03:45:56PM +0800, Guan-Chun Wu wrote:
> Replace the existing local base64url encoding and decoding functions in
> fscrypt with the generic base64_encode_custom and base64_decode_custom
> helpers from the kernel's lib/base64 library.

But those aren't the functions that are actually used.

> This removes custom implementations in fscrypt, reduces code duplication,
> and leverages the well-maintained,

Who is maintaining lib/base64.c?  I guess Andrew?

> standard base64 code within the kernel.

fscrypt uses "base64url", not "base64".

>  /* Encoded size of max-size no-key name */
>  #define FSCRYPT_NOKEY_NAME_MAX_ENCODED \
> -		FSCRYPT_BASE64URL_CHARS(FSCRYPT_NOKEY_NAME_MAX)
> +		BASE64_CHARS(FSCRYPT_NOKEY_NAME_MAX)

Does BASE64_CHARS() include '=' padding or not?

- Eric

