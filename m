Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34711C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Mar 2022 12:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DbHeqBmeub3IXNgpNpXwxQEP5KJEOmozlPFdl+jrVb4=; b=uGg4xPX+qCUR3ziafeiy3N1SZq
	YmFjy9oassUhlqq/TupwW6nlyle+uWhXhQXEIGEH/ST+V07+T41/TNcGRsGaAwdEIfHWGGP/l1fzj
	YcNlhmz3UIcVLsDaJh2rhkIn364J+JhGotWK2xsPivXvJs/VwZ+AcM3xdm/c7j4oW1OdJ8iAb2dQe
	nTp0mlTyZLCN7pfy94l4qTGqlT5jTThuKBxqUanH/lseFd5vrByGsqTz5yAKKaBK9Dtu1PDR/dDOW
	HG7gOxVoyZZEKmlxjymThJtwJPbklrrl23rS4kRXBeZspLUBeXeFl3aJdwJNndid/Iqh9IfXnBlON
	m0XjM0lA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nZAtg-00CAqy-TU; Tue, 29 Mar 2022 12:24:28 +0000
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nZAtc-00CApI-Lr
 for linux-nvme@lists.infradead.org; Tue, 29 Mar 2022 12:24:26 +0000
Received: by mail-pj1-x1034.google.com with SMTP id gb19so17255889pjb.1
 for <linux-nvme@lists.infradead.org>; Tue, 29 Mar 2022 05:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=DbHeqBmeub3IXNgpNpXwxQEP5KJEOmozlPFdl+jrVb4=;
 b=3IFSkxrjEY0kgqIH5AF3jinprwQV6MupXoDqc/cYBqfY/yqMU2lDyZr+OhQlFdBOia
 Eh0BHSWzVdlKCoTUtRr/AgxhqKc4QuskCaWi156M7MIb1FZH/ZDQL7JHuwo2/THS7h1F
 gvT0YF9WHeBDrkKFKloBRzvigQdr4tqYq2NeTXDWFFKrjAhJkofGN5MY0Wq8wHIjewF8
 CVKZniazVDjsqUtjnQtNoxDUNK633AMJJGlk2Q8lMBGty9VlgXvr7+4GHWBVb2YJT5mR
 d+v4+33oMH71tiIo/WLEcyvteR/DV1jwQwI1pb9cqPY6h2C/Iov3z4tHiY2onEHygIKf
 Xp0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=DbHeqBmeub3IXNgpNpXwxQEP5KJEOmozlPFdl+jrVb4=;
 b=S67fFDO0QmniMdsuepxyGog6BpAwSZIpcqa/KBoirP+KsI8rhIe6ZB6pKI+a5DSjy0
 53GDNYzvMkFNTJdrYnFThqn2FOzdjDPuu2+LMcnEXJfsvXilxq0pQG7Ms2lvdjsCTdFs
 4ePNWITK5Fd39UUWtLoUX0ZB24Q7Wg54KJdRtsQKxlTbLVcNRRn4Ced4QXsmIRB6KivG
 h8FuC75ZCJoTLhy5VqNxZPT8RXOs2GzT/y18ocubM2G0JAvUp6Oml9ZCmIvWZIzM8lQO
 +B1WUoJ2Po4Cj/v3ZFkUUnCWGQvKzIGXSPi9uPc9rexFk5oG3OZgxkPaNLSkZRO7s6X3
 VxFA==
X-Gm-Message-State: AOAM532Okjwow2T8buu9kLPUM5UVeMBP7MO5/sufOqRChbmKIcWflVDE
 WzKElQiEHy8EPSdUsl7dMo0LbQ==
X-Google-Smtp-Source: ABdhPJwpVnKb/gfRQoAuLbAhnBEbGdj5ibalqQ5j3N6zvFHH5YG7i9hzQst4uYti3ZHYMUZUmWvwZw==
X-Received: by 2002:a17:902:8491:b0:14e:dad4:5ce5 with SMTP id
 c17-20020a170902849100b0014edad45ce5mr29253372plo.76.1648556662491; 
 Tue, 29 Mar 2022 05:24:22 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
 by smtp.gmail.com with ESMTPSA id
 t34-20020a056a0013a200b004faa8346e83sm20386224pfg.2.2022.03.29.05.24.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Mar 2022 05:24:21 -0700 (PDT)
Message-ID: <69c1b01b-df24-d6b3-c1ca-06f3f3f850c0@kernel.dk>
Date: Tue, 29 Mar 2022 06:24:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [GIT PULL] nvme fixes for Linux 5.18
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <YkK14fRnn3GVpGxQ@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YkK14fRnn3GVpGxQ@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220329_052424_821121_9664A696 
X-CRM114-Status: UNSURE (   8.53  )
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

On 3/29/22 1:31 AM, Christoph Hellwig wrote:
> git://git.infradead.org/nvme.git tags/nvme-5.18-2022-03-29

Pulled, thanks.

-- 
Jens Axboe


