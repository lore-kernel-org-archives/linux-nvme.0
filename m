Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C65AEC77B70
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Apr 2023 15:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TqlkhVbab+EjQ6gUsAOVQyNn+g6U3XFNNKE9iP//FAc=; b=xFJbuCFpuAqOUElQQXoCPO6VOJ
	jc8fZp5++cUcnifgpVDXz3gbtjc5puOrAtGYqt6O4Ce63UVGk3ac6xl4xRYjp/eORAEXyVzly4Ozi
	WXE7FLsfy8irR9OJ+5GNq4n9Pdr61DhzW6NDVtK4AQ+YMUkurGvRwd4d90hNRpshvnOssfv+pld8z
	DtR+YfjPpkbVOrfg9jGqKzFLgmzRIDJSth/Gk4G8jfJ6p2m2hOT8jLcSb5jUT5PfGIN58L5qC+PgV
	/AWM9XE9UklUZuk0XUvPCwBsE16bCOr8ew6qxlqeqbNs/ZebR5wWaLkDpG/81CTNFNdhunTuTgmUk
	lkoFRIJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poQUt-00Gmd8-0p;
	Mon, 17 Apr 2023 15:10:27 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poQUq-00GmcK-10
	for linux-nvme@lists.infradead.org;
	Mon, 17 Apr 2023 15:10:25 +0000
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-3f16f792384so3149575e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 17 Apr 2023 08:10:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681744222; x=1684336222;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TqlkhVbab+EjQ6gUsAOVQyNn+g6U3XFNNKE9iP//FAc=;
        b=DXTd0Rq1UiLtAS1Z+M763qu90AdjaqQ/RsnyFKnvJbT5Y2MI/so8e1ZNn8nl6p4aGp
         NT9e032WWSalG0lG9fjk1Wo7aY0CJ61zK7Ya6AtJn3JbJIXjBpzb4WZEV0E68xcpjQlJ
         zfySqL+tI+zx3By+uQPymGUDL7NlopC/hEnqeIlAa9y6xz0L5EoLBTWZcciHdbcur0Rl
         J66O7P1szELTEI+B5Yu44CFjzRSwnQDMPm4uhRzRj1vIBshmexExv4TJH8AbC076EiJT
         X4OJWTZf4c7r3GyPJugv+w3otkYq+OqUm0eaphaw4Cn+zB3H+cOgnDzTEHpVamvvcgnk
         PiGw==
X-Gm-Message-State: AAQBX9cI0bZKEtGp2/SqFLGn6TK1NNASDKFmoLU7CD58Kvn6MbbjoUaI
	eLJwELAeSlnCVpmnBQLWrlO+VbYzd3s=
X-Google-Smtp-Source: AKy350bS1RdQSAJcWSf6GDd+f2TwRNo1jDZJcMYugxATqOBRJKk038NTj7YhzNZivac70zjR80eX+A==
X-Received: by 2002:a05:600c:6025:b0:3f1:75a5:a369 with SMTP id az37-20020a05600c602500b003f175a5a369mr1499695wmb.3.1681744222332;
        Mon, 17 Apr 2023 08:10:22 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id c7-20020a05600c0a4700b003ef4cd057f5sm16192594wmq.4.2023.04.17.08.10.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 08:10:22 -0700 (PDT)
Message-ID: <36976756-b4c5-f2a5-34b8-e9731a49c477@grimberg.me>
Date: Mon, 17 Apr 2023 18:10:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 08/18] nvme-tcp: do not set MSG_SENDPAGE_NOTLAST
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Jakub Kicinski <kuba@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Chuck Lever <chuck.lever@oracle.com>,
 kernel-tls-handshake@lists.linux.dev
References: <20230417130302.86274-1-hare@suse.de>
 <20230417130302.86274-9-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230417130302.86274-9-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_081024_346124_66367D25 
X-CRM114-Status: GOOD (  11.32  )
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

nak from me.

> MSG_SENDPAGE_NOTLAST was introduced with commit 35f9c09fe9c7
> ("tcp: tcp_sendpages() should call tcp_push() once") to fix issues
> with the ->sendfile() call, and the implication seems to be that
> the flag should be strictly internal to sendfile.

no, the use case was to allow sendpage consumers to build larger
tso packets for large payloads (splice being the primary one), nvme-tcp
also benefits from it (as do others), just like sendfile.

> Hence we shouldn't be setting it on nvme-tcp, and anyway doing
> so will cause TLS sending invalid data.

That is something else. I don't recall the full details on the
discussion with Jakub, but it was not my intention to strike
it altogether, just remove it if !sendpage_ok.

