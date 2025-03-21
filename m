Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA630C36000
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Mar 2025 20:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8di2+5db+G/faMtWmD76yKgofncq+owzXn388GWGPKs=; b=ICfHzOm/WejmSTnMHpncYRA54j
	YggySOJ+K+oQMcGTKMG2muAK5Ur2a6TiUGH08TKjQItc2efm3Xbr+p8PkN+uOtWD7WdvlNQJlWG8h
	QieAB9gcQbHaovfK9zg/Y/dsFDwY7AQYyU5qpiDt99hvu+kYixuLViIMdNl9kVhz3rT0WO5ySJ56y
	sJcD93cejQO9UHdzew/C4etzwbTWw70CrJJSt+mgfNhgbhWmjQt1zqtP5XD2QRtDXq7vHrAXvqnKh
	frrQ4tWUb3am9xHYv2c3ngCz3ejKsdJIYWwERN0hXqV9ah19Yjb7R7YMOFY/DAnFnIFBqZPGhp4lH
	A5jT4RBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvj7f-0000000GDCv-33UV;
	Fri, 21 Mar 2025 20:37:43 +0000
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvj7d-0000000GDBP-0xy5
	for linux-nvme@lists.infradead.org;
	Fri, 21 Mar 2025 20:37:42 +0000
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-abbb12bea54so188837366b.0
        for <linux-nvme@lists.infradead.org>; Fri, 21 Mar 2025 13:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742589459; x=1743194259; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8di2+5db+G/faMtWmD76yKgofncq+owzXn388GWGPKs=;
        b=D3kh0fV2FPX8mJxNlPwiyjEufnTbdQRRgolTvWQ3C/FA0y/BdVAcyx2UB02wfO99je
         mkIolfTiJgXPUcp/McvxHcsanzC+d4ethZ3KdvqXfMLJpIMORvvwbI/mSqW44f4JeIuY
         iMRDpy0OjU0FJyeRgVQtTTyP+Sz9gyeLYUUhkZQTt61pZB7JYYFMqlJHX92gCiiMIN8a
         YR0LJPpmP+YiEQFwvTDrbqk3G+ER1H8xfBKgZr4SRE7gCSQryiDZ/QfPKUxPlW0Dgtvo
         eyb9R8jHZexm0UYf2Qh2SdFSfigavYqAFmcg/gGuR+YBbLgq4/7zpJfFvqNq/Nd2f4s8
         Wj2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742589459; x=1743194259;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8di2+5db+G/faMtWmD76yKgofncq+owzXn388GWGPKs=;
        b=UeoGszzfHA8+ZStIqEX8pl0pv8RcnQS3oH29HWt8cnE7yH+ZBUQSbsA86YEB3Y8Rbc
         JUZpP0mkpfsLMWIiKbKXjO8S/87vhs+Vkp5SKUL2g8iO11yZy/oLW9CuWw2dsUrmV6JD
         qSfOPx4DBHvn3uueRVg4Zkn+NHWv/wkR3zCSUYSdSILvhiW0UTdFcUzMjJ8boarXhS9s
         V8CMZgRnlfBeLiTTnmnsenQjLvQfLVHAaqkQVYbEwUw68GPYKUpwziMzDy+OiBXTlPDw
         57zPnXLcf0qYnDp7T6Jq6StwqVp7dcTNt7gMjkslUnfZzcXSBBoBRHQbxR9/I7xwMnxY
         pK6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUOnMYKW9vBObwrH1kFJghgFjRoLCbFdg9PG/TL0+irONhwMlLb8/Sbf3OUTOZGUO/qtucBFCC79SIU@lists.infradead.org
X-Gm-Message-State: AOJu0YyjWPGAgKVWVy4GB4fK5/CZHxpT8V00dXbGaDSLPw61reONYQDa
	YqghoZ8G5DJ0KEsT2ryVDYOpgxbF/jID+gicJd44lRbdYfcM3iPH
X-Gm-Gg: ASbGnctmO/48MmbcX+7iMxQ4FkEaIAqVjG8xeGy5tFn77TJoTa6rDgTnDsvZkfbHj3p
	jI6zaI6oBz7TMSXzjPkpL+sy0bJkXu4IEy06Tgn9elpogWCahMDTBZWqTY3Nnd1u+DmJOi+stXu
	gnd0ZFxPx9IzCrAp8AUB7xC0qDHrqWSsHztYFtM8SuBVJT/YE2dWnLW3WEah0lz/lqN2cGTU774
	AAUa+gmVzn0vnwUSi8Zf8tSMgeO56IbB+Rf6sYMM8LHy0iX4RpXzkD5E7RYkS93bJKojUUU6R+q
	Uk4VmxMY4JM0SUS5O7UlMD0FC9u5nPrR7eiG2l+3YwH2ck9CM0szEA==
X-Google-Smtp-Source: AGHT+IHrRiJ1iTW0Z48ukRmGGb6XVNgOoztXQYwBBfo+m+iTY3JPOOIta58QVGB1CkULhOEnWBIKNw==
X-Received: by 2002:a17:907:c5c9:b0:ac4:76e:cdc1 with SMTP id a640c23a62f3a-ac4076eda87mr70308966b.21.1742589459101;
        Fri, 21 Mar 2025 13:37:39 -0700 (PDT)
Received: from [192.168.8.100] ([85.255.236.254])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef8d3d2dsm211581666b.60.2025.03.21.13.37.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 13:37:38 -0700 (PDT)
Message-ID: <ee6c175c-d5b7-4a1f-97b3-4ff6166c5c73@gmail.com>
Date: Fri, 21 Mar 2025 20:38:32 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] io_uring/net: only import send_zc buffer once
To: Caleb Sander Mateos <csander@purestorage.com>,
 Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: Xinyu Zhang <xizhang@purestorage.com>, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20250321184819.3847386-1-csander@purestorage.com>
 <20250321184819.3847386-2-csander@purestorage.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250321184819.3847386-2-csander@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250321_133741_276477_8AB94F6B 
X-CRM114-Status: GOOD (  12.77  )
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

On 3/21/25 18:48, Caleb Sander Mateos wrote:
> io_send_zc() guards its call to io_send_zc_import() with if (!done_io)
> in an attempt to avoid calling it redundantly on the same req. However,
> if the initial non-blocking issue returns -EAGAIN, done_io will stay 0.
> This causes the subsequent issue to unnecessarily re-import the buffer.
> 
> Add an explicit flag "imported" to io_sr_msg to track if its buffer has
> already been imported. Clear the flag in io_send_zc_prep(). Call
> io_send_zc_import() and set the flag in io_send_zc() if it is unset.

lgtm. Maybe there is a way to put it into req->flags and combine
with REQ_F_IMPORT_BUFFER, but likely just an idea for the future.

-- 
Pavel Begunkov


