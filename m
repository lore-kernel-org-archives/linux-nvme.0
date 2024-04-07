Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2EC8CD128A
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Apr 2024 21:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=gJZhdF9915luJpKh06ffvi0sir
	c6ia2epj87Tml/Z21YuciiNieJAbNSDBv7DZNkVynPXVK7/ctRI23/BcYhyAPcEnfQH5I7MtrOIUE
	n0tccGgLCZ2HdcEzchxy9N5tkcnrTNEXhpEpPdgsq7Gr5LIhc02IDxncYcZVvOljBNiLSVefvPkQX
	RwHxmXbp8nPbmN4eHEY0deJz77U+8asJjl0qWiLZsqKEUej1oXHjrNdYpQmV0PuAk+WJszCIQYt0C
	e6MdBJO+GcorKtgOFkG8mGvnUioZBeVoPjCMateY8OL3jYf3f6HohuNng9PXo6Hajh4td/soGUVnJ
	kiy3M2Tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtaU4-0000000Davz-1lkB;
	Sun, 07 Apr 2024 21:55:28 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtaU1-0000000Dauy-2nX6
	for linux-nvme@lists.infradead.org;
	Sun, 07 Apr 2024 21:55:27 +0000
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-343d32aba7eso820885f8f.1
        for <linux-nvme@lists.infradead.org>; Sun, 07 Apr 2024 14:55:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712526923; x=1713131723;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=BaQINmN7VX02zqQup7KynC5mdN4JrrgDJa1VwRFEaIk+gSZrBbd5t5vsWxFG3kRFR0
         I1CY9JIoNRFu288ZyS8RKkbFNHlpMJqdipRmCGa7B/DiwsSMixFILVPDobr3mYrt7hQk
         ocrtPrxTlRsNYn/MpckQdWLRX5OjguAzgthv1a91Ce5zpr9pZv4ihL4V/NH2fmhgYnSC
         LBq2Fsr6PdYa8pHdZ0I9XRzUicpMWD1pPVVLwwSwm0x+4zYXHaJG9CIV/Gr/A46+xNBG
         jC/nEs5eiMTJTg8WNVDh28wAQ4ULX5Bodr0EEXc0MOect2e4M5H1tD6OFx28jsLgorJd
         WogA==
X-Forwarded-Encrypted: i=1; AJvYcCVjm+kp2H5blumWRhwmshq0bCxDAEhcziEh1m3QqmVvvJijX1Rv1yHDXD5ufbZlX0D5hX1tGaZUri+Lkpu54z5/J6rGvTOCK3Ol5Swqfks=
X-Gm-Message-State: AOJu0YxkPa33SacxhO9U2tv7/k4Ze3sp421OOd+FTb51AM+DLPDnUL6P
	AS5VoUeKKMI7XPORDBFwpOafpvdRzNxZVtpnCgtxRJpr4kRPAQJquAbQVixl
X-Google-Smtp-Source: AGHT+IF3wPX703zKsmGZnrXn5L9vje5NGTFsUw31Aur5vr6H4ASEO29SCBO/mkgpGssdAeF2Lwd89Q==
X-Received: by 2002:a05:600c:3b08:b0:414:b440:4c66 with SMTP id m8-20020a05600c3b0800b00414b4404c66mr5781842wms.3.1712526923090;
        Sun, 07 Apr 2024 14:55:23 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id y16-20020adff6d0000000b0034335f13570sm7404526wrp.116.2024.04.07.14.55.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 14:55:22 -0700 (PDT)
Message-ID: <c0d2063a-92e7-4efb-91e6-adf2a55c8b9b@grimberg.me>
Date: Mon, 8 Apr 2024 00:55:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nvme-cli] nvme-print: Print cntlid number for controller
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, dwagner@suse.de, gjoyce@ibm.com
References: <20240405121057.297071-1-nilay@linux.ibm.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240405121057.297071-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240407_145525_844822_607328A9 
X-CRM114-Status: UNSURE (   4.15  )
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

