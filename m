Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56940C25B75
	for <linux-nvme@archiver.kernel.org>; Sun, 26 May 2024 10:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:From:To:MIME-Version:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=V7lL81myPBdfM+DTc29F/Fh7V6UWFBfd1VF1hjr+pPQ=; b=gJGQ95yCdbNOhsgQNWOvjf9dTV
	UShy3bItGG8Xwk+ZCAmd9gI5IfzzF4YDrK1P7TjHHACAUurK11xBVTUqzFsyV+VVeamH6/BDpBlZl
	Fp5+irv/eBTJamKlYudr4Y4drIP6Wye3PMLM/qoevTzIhW6vvjXCX46O8RUt1LG+w3uGd4EWc2gOh
	3KmmJyTI7qC38Q//Weu7dXpAm2dxVAtahgN5150Fk0Rcz/66wjHK+oCenqBrKqEN2B611vdazv+RL
	nJGn0HkoHzlC4eUDBbPw3rCV7ouDytx04a2FIJE/YnoY2/s4DXzvVg24E7uevIKo1/4ZEVg0b57+q
	uFjH3hig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBAwW-0000000CXts-3uIf;
	Sun, 26 May 2024 10:17:32 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBAwT-0000000CXtS-2W5M
	for linux-nvme@lists.infradead.org;
	Sun, 26 May 2024 10:17:30 +0000
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-354f89a59c6so568174f8f.1
        for <linux-nvme@lists.infradead.org>; Sun, 26 May 2024 03:17:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716718647; x=1717323447;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V7lL81myPBdfM+DTc29F/Fh7V6UWFBfd1VF1hjr+pPQ=;
        b=mUdiKfATm6Eg/Gfi5ZTC8KoVQODzrTMqRYHUwYCEBGhi5GR+s6eRmr5uQWPvxdpcZ4
         uZF8c+Q4Ic+UDz9ZTQPd5KP4tFmQC5sw4mHVS3ooEs0ZCEK/hkFknUUZQoMU1itDpdfu
         N60fb8MBA7S6nkJsQ+2L++qSyhD3hNah0/h+TtskvZFQwCEmNIj5Wc4iarrPtyM6hPmz
         SlUK50I4IGN0WmLxyIoiX2w7d1OXQ8L/mgnDbtcy6ejwBopilAhTS2DZcpv3IUfWkr6F
         X3EF/6iIZeM3VPEEsbfHzAcvRGYDXGIYvMbf+ADTDpucVe+8SjyNvqa6BcQHB5cZdl/M
         XX4w==
X-Gm-Message-State: AOJu0YzvnFwjP5q3ki8am50bZF5LhPfGenyQmhIdm7UqFF5RpUgWVj+D
	/QFyVOJxEAjxWIQ2BJ+wXrEirxhh3K+3s3mo3rLkbH9ft5JRV+K0yEKQfSnf
X-Google-Smtp-Source: AGHT+IECC4VPwXqGpEwYU026Mrp/1/q71HnVJqN7/f9dbya/NwD9PN6SSxGqFqnd6CB5w2Igmj9AnQ==
X-Received: by 2002:a05:6000:41:b0:354:fa0d:1423 with SMTP id ffacd0b85a97d-355270554admr4541836f8f.2.1716718646706;
        Sun, 26 May 2024 03:17:26 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a1c9402sm6103428f8f.86.2024.05.26.03.17.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 May 2024 03:17:26 -0700 (PDT)
Message-ID: <64656570-645e-4b82-8ef6-06cb36916f5f@grimberg.me>
Date: Sun, 26 May 2024 13:17:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Subject: blktests nvme/042 nvme/043 fail ?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240526_031729_661376_98F9D900 
X-CRM114-Status: UNSURE (   4.46  )
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

Is anyone else seeing these errors?
--
nvme/042 (tr=tcp) (Test dhchap key types for authenticated connections)
WARNING: Test did not clean up port: 0
WARNING: Test did not clean up subsystem: blktests-subsystem-1
rmdir: failed to remove 
'/sys/kernel/config/nvmet//subsystems/blktests-subsystem-1': Directory 
not empty
WARNING: Test did not clean up host: 
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
rmdir: failed to remove 
'/sys/kernel/config/nvmet//hosts/nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349': 
Devnvme/042 (tr=tcp) (Test dhchap key types for authenticated 
connections) [failed]
     runtime    ...  0.316s
     --- tests/nvme/042.out    2024-05-26 10:06:14.563557068 +0000
     +++ /root/blktests/results/nodev_tr_tcp/nvme/042.out.bad 2024-05-26 
10:13:42.430937572 +0000
     @@ -2,15 +2,4 @@
      Testing hmac 0
      disconnected 1 controller(s)
      Testing hmac 1
     -disconnected 1 controller(s)
     -Testing hmac 2
     -disconnected 1 controller(s)
     -Testing hmac 3
     ...
     (Run 'diff -u tests/nvme/042.out 
/root/blktests/results/nodev_tr_tcp/nvme/042.out.bad' to see the entire 
diff)
WARNING: Test did not clean up subsystem: blktests-subsystem-1
rmdir: failed to remove 
'/sys/kernel/config/nvmet//subsystems/blktests-subsystem-1': Directory 
not empty
WARNING: Test did not clean up host: 
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
rmdir: failed to remove 
'/sys/kernel/config/nvmet//hosts/nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349': 
Device or resource busy
nvme/043 (tr=tcp) (Test hash and DH group variations for authenticated 
connections)

nvme/043 (tr=tcp) (Test hash and DH group variations for authenticated 
connections) [failed]
     runtime    ...  130.513s
     --- tests/nvme/043.out    2024-05-26 10:06:14.563557068 +0000
     +++ /root/blktests/results/nodev_tr_tcp/nvme/043.out.bad 2024-05-26 
10:15:53.258812323 +0000
     @@ -1,18 +1,19 @@
      Running nvme/043
     +FAIL target setup failed. stale host configuration found
      Testing hash hmac(sha256)
     -disconnected 1 controller(s)
     +disconnected 0 controller(s)
      Testing hash hmac(sha384)
     -disconnected 1 controller(s)
     ...
     (Run 'diff -u tests/nvme/043.out 
/root/blktests/results/nodev_tr_tcp/nvme/043.out.bad' to see the entire 
diff)
--

