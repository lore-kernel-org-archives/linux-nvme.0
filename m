Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCBDCC3ABB2
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Sep 2024 21:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ho6Q23pkuFpyTSVtDWNL6V7OsfkIY1fIInxQgfCro+k=; b=HhLKzRBflBsB1frZTu9pYMoUoz
	HFG6Sg/YbHv0xnO4qbuMdb0cyUchbKhj9jH/xkmNM86ndDavJIij8DVcbldEhJXpcFR9lEOGiFFo+
	ltDYqFaWDci6YrShsgOEhpVpwYV/Z9frHH4fpDhUcr4abGxcb7cO4BfCbSC6l7nMCdxmVOSVfwMmS
	VzakWqZbjTxUyk236Oe5saLyMFlyCfyWpL9+Hycc9RoUsfqa7fhmep6X4zM67Q7gLXYjUMAGWO3bb
	xq8n2RSoqw1uJFZfng/x0byHXTvrwqyJ0MGzFV9Icd1WbTgK7faVscyx4S/fgDKjLycCeagyyzbQx
	xMoHnDDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sqJDI-00000004vUd-1DNi;
	Mon, 16 Sep 2024 21:24:52 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sqJDE-00000004vUH-4091
	for linux-nvme@lists.infradead.org;
	Mon, 16 Sep 2024 21:24:50 +0000
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-205659dc63aso48331675ad.1
        for <linux-nvme@lists.infradead.org>; Mon, 16 Sep 2024 14:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726521888; x=1727126688; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ho6Q23pkuFpyTSVtDWNL6V7OsfkIY1fIInxQgfCro+k=;
        b=hWCZm6ocrqcoKbcRTZvJukb44Z0aA+CtMbKqrqEKUAqZ6+UkcwLvNMZnw1QdcLlSt2
         F9Bk53OzAKSMMpUi7rUY1IfcU1xISQ1dQGf8lEYc1wgbd7vAJg7R/DbdqYmu0Ffzb/9t
         P1PeCwpY6NdZxiG3pwg0viSbNAhpb1+/xexXir/SZUV1esw0cvSQn+B1TG4nObY8MsD+
         zIVUXa9DX73Cf78F4C8slJlnZPMWaN0vszpnrIUmDT/0eZPcbpHgLta64Mju2i4kAgFd
         +ppGuGKhEfg6tefq521xjied8woHDucKwIKj8O+VwiluRsXIY/dhZ1KQjaPPE5DH/lar
         eYbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726521888; x=1727126688;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ho6Q23pkuFpyTSVtDWNL6V7OsfkIY1fIInxQgfCro+k=;
        b=Vv336cjBUr8g9iX6gdV9Z+xthr0NKeEujlzEJv50jceU8GfI+A0mi/I/MWQZUgk0U7
         cyRGlqxuTDn/K/g7D45pwrH0zj999nQZ3oSQQYE8xzYnx1GFFy75A48KbWXk1+1F8zsF
         2iD+hTpIicpSvH9Sr9cRnth8sUsBGQcIZX7jJfNZnMg/D7RF9bPDoLA9u/p24Yoz7Ian
         hBfK0pkbZTtcc6F8IeZFflHRR9NTOyy+JOU5bj1eNePthHf/SOr48+jXi5FaGjSG8dGF
         xs+WjMY7bSERXZSwulzYBvjwYCEsjF2frlj3weU8+8TWLacbxQoRKTHXol7lUIZ3SxfL
         hDFA==
X-Gm-Message-State: AOJu0YxsXQoRvQQYrmeQjIjqPaPrzxlH93Vn4hplIphula7d3LzwIlNF
	rB2xa8y2ocHtIaTHSsNNwEiZRsfdqSu+JveEiZA0wvRMHq3XZNJA3lQHRw==
X-Google-Smtp-Source: AGHT+IE7YYx6oV+Rj8qUU8CaBV4A9CBoTAq5tCMJ+EiOjJ49GufRYnUHzUjIhiJKWCVWXJHC833grw==
X-Received: by 2002:a17:903:986:b0:1fb:6294:2e35 with SMTP id d9443c01a7336-2076e4854f3mr240671185ad.50.1726521887629;
        Mon, 16 Sep 2024 14:24:47 -0700 (PDT)
Received: from ?IPV6:240b:10:2720:5500:70e1:967f:afde:e27c? ([240b:10:2720:5500:70e1:967f:afde:e27c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946d63c8sm40174845ad.156.2024.09.16.14.24.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 14:24:47 -0700 (PDT)
Message-ID: <e75fdfbf-e503-40fe-9252-28e905bafb53@gmail.com>
Date: Tue, 17 Sep 2024 06:24:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: convert little endian NVME definitions to native
 format
To: Caleb Sander <csander@purestorage.com>
Cc: linux-nvme@lists.infradead.org
References: <20240916154422.356691-1-ikegami.t@gmail.com>
 <CADUfDZrqAgp49K2Ak-b230ERY8P66aXA4iAoCyyYr45PAbq+1Q@mail.gmail.com>
 <1bcdab96-f2cb-4116-9f04-4016b01bad36@gmail.com>
 <CADUfDZo=WwCTWwmY+UcUA7zpXb9CMpOsNC0icat7opwwFpJh=A@mail.gmail.com>
Content-Language: en-US
From: Tokunori Ikegami <ikegami.t@gmail.com>
In-Reply-To: <CADUfDZo=WwCTWwmY+UcUA7zpXb9CMpOsNC0icat7opwwFpJh=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240916_142449_029359_17FB73D4 
X-CRM114-Status: UNSURE (   8.03  )
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

Okay I will do check the actual behavior again. (Since I thought the 
definition value works as little endian byte order on the big endian 
environment.) Thank you.

On 2024/09/17 3:12, Caleb Sander wrote:
> Why not? CPUs assume native byte order for all arithmetic operations.
> The fact that you could print this value implies it must be
> represented in native byte order. Non-native endianness is only
> relevant when interacting with byte-addressable data external to the
> CPU (storage, network, etc.).

