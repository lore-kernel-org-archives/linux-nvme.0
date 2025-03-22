Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E432C36008
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Mar 2025 07:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Z7uRXzyqaY+8CoL8VH2NY3P3ba5PhoIILfMU4ndnZgQ=; b=HA5aOszzTSXbabwUaBVm1DXVNI
	cKIm4MR7zzUHpkZjNeUZiQdLV7s75Hgw1/lObpSwKeIqbZByxC/ajMWHxD8g6Jwa46B5NJ1MbZI3J
	2hwm5FLRkfGdX2XlNKQzORIAvWgIexD3PBMxhu5d66gTfpHVDoUxEbDXe29WYx7ILw1l7q9pZxii/
	FUmYEZgKd3UjJIsaJ0586cgEWD5ZesAs4IaKdFohnO0gA1RCw9G9KhlAI7Q27kJmr7WfdHddqSm/S
	6AFspkxO2TL02MILmC2Qpb7/HJH9IfVmA9GFHS5MHBl0afzNv0bLVMkl5p13US+30nMD0QvTr2GEi
	wrJNHRCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvtT3-0000000H2Qp-40kh;
	Sat, 22 Mar 2025 07:40:29 +0000
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvtSr-0000000H2PR-1c1U
	for linux-nvme@lists.infradead.org;
	Sat, 22 Mar 2025 07:40:18 +0000
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-43d07ca6a80so12930565e9.1
        for <linux-nvme@lists.infradead.org>; Sat, 22 Mar 2025 00:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742629215; x=1743234015; darn=lists.infradead.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z7uRXzyqaY+8CoL8VH2NY3P3ba5PhoIILfMU4ndnZgQ=;
        b=c9xWGbnvxKbC5zIswKzo2At7Olqzq69oNKN5xpN/DQfiR0cVQQ3ZqowMOJCWXuNctq
         BwXtDuZREZIgJPBPuZiUmfyMn1A/QrrEkAzR6eLXfzAebSUfewFBeMFWV+3WwPcoWBT3
         j3zdSbXGEIz8C4eVu2cc2qqQQsdyK5KE7KZu6o9X1TcbhN8tvPPoDDUfQLvaJziDmbEz
         d6nHjBhp4nToa1rqOXEJQbiZK9c1gG5HJ0yogtjFaYPnlGeAnZC8VIvrZOni/dgtAMZD
         Z6AhlR372Dwt53h1a8AZ6cOPoKJOHav722iw9rcTJQ82JRauNhtdL6RO2LDpGsyd1qsu
         iasg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742629215; x=1743234015;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z7uRXzyqaY+8CoL8VH2NY3P3ba5PhoIILfMU4ndnZgQ=;
        b=QDraxF0hpW9ZUyDsbJdmelwzoXDrhLcYT22LeER8eNw0rhKe5xOJbZPd6J7OYnNXbz
         aD9m3YJeM9Od0yiKQqnM+fjgXcxXiJq5nHdEb16tijA7Bgy3BntSdbxtov9Wz95n4fUU
         wp4/RhaF785ZvAgzqJOdzxw2AcwbO24DoHhQsR3VxB6UfC1xHF4e8ZGvcBMTLyxXPf1s
         eVLPKDptAbbFuzRqk+pgaoGazXCcCHokjTR2EiyjtWum6vot1eP6KKoAr5SVBNDrJwVR
         ySX5ZCklrgiGyQLRNwdvHAulGHJuDY4iFStszlMO6lKBjjz2odNJpt74MPU9RO87IbVW
         cRmg==
X-Gm-Message-State: AOJu0YzjENZonuHv0cyH+Hml5Lq70PrbLx959DrjvCkwfvP+4yzFzpKi
	waI+vzV4+6WajtSdqpxrWpanOwbzTa0P823oP+TE9BO2W5Pw/6t64TMvPtFrXASA/Cjh4Tl9TZv
	X
X-Gm-Gg: ASbGncuFh1G5bF540ZECpqXsDfpMOwMG6Ou6qtL7U+roZVavEhmjzBRf7YOsX/0lbIx
	cDQvDNvcIKecfTDjnRpqL8Rxehx4JKO6a3I1oyZW+s/upOeZWLpeEhqgdDBNycQKyBX+WqlLjOG
	kKGPJUInZPeNrPvLqs2e/FKTSiG5o0UTK/jv+63RKrxlLrVdg9fDVlxu5SGyHZ2RybWOWM0AbDp
	ZIkNP5EQIN/YeR5731EhxaPuNl7eHel7uTUsyv4Ni2vBG5mG40sPaFoftNIH+ATu2nu7OGLW9oI
	erS6RymLZDfkdJssHFHrL8oOq1dOj/s3nIwqY4wBiG5xrV5SP2kEQZwrxBTH
X-Google-Smtp-Source: AGHT+IH/6mAzNtstcGPP3Z1Z+dRifyMvAUXdmZtT7jMRbWwvmNqZb9FjczZLnTCieo2ODO1FEJInKQ==
X-Received: by 2002:a05:600c:3b9c:b0:43d:934:ea97 with SMTP id 5b1f17b1804b1-43d50a4ada0mr36387865e9.27.1742629215582;
        Sat, 22 Mar 2025 00:40:15 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d43f43e2asm102366245e9.11.2025.03.22.00.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 00:40:15 -0700 (PDT)
Date: Sat, 22 Mar 2025 10:40:12 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Hannes Reinecke <hare@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [bug report] nvme-fabrics: reset admin connection for secure
 concatenation
Message-ID: <a10a314e-0a2b-4b28-8aaf-38e4e2129e3d@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250322_004017_423904_007589D7 
X-CRM114-Status: UNSURE (   6.02  )
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

Hello Hannes Reinecke,

This is a semi-automatic email about new static checker warnings.

Commit 104d0e2f6222 ("nvme-fabrics: reset admin connection for secure
concatenation") from Feb 24, 2025, leads to the following Smatch
complaint:

    drivers/nvme/host/tcp.c:2359 nvme_tcp_setup_ctrl()
    warn: variable dereferenced before check 'ctrl->opts' (see line 2355)

drivers/nvme/host/tcp.c
  2354	
  2355		ret = nvme_tcp_configure_admin_queue(ctrl, new);
                                                     ^^^^
ctrl->opts is dereference here

  2356		if (ret)
  2357			return ret;
  2358	
  2359		if (ctrl->opts && ctrl->opts->concat && !ctrl->tls_pskid) {
                    ^^^^^^^^^^
so hopefully this check can be safely removed.

  2360			/* See comments for nvme_tcp_key_revoke_needed() */
  2361			dev_dbg(ctrl->device, "restart admin queue for secure concatenation\n");

regards,
dan carpenter

