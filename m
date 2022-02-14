Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7EC7C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Feb 2022 10:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I2qt3+FoK96nE1glGYDfvHEmytroL36t21/ibFTNEps=; b=YbqymZZTiVaMPAvGewaE25dQon
	wr4/JMzBIAndWAi4JtTMKh55qNtDzYVnpRFMAcI9htG3i0avQ/ELo7pwP8W9y8gxKwXX2wrGMx2g2
	zDuXEbsQu3kYgqsa7tJKC5YD6c9jR0kWqpP/q+A5UDL/sESuk2EhXM8+aGeC0lfdmFH8f5NosOxts
	C6rZamXu1rrtXjMKH9+QrQwiSvm7U26uJRPSxz7pWwtuOIaCURUGQVoHSzAYNAR/SNq5rz0mHCkdQ
	HF7e76ggC7t1IiyuBISbqxnK6BuoLrf9MOhshElWHUIj6xOJ9EqWLHeg45eINwHigdRQ258MAG07H
	2SnF5hAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nJYo9-00EZrS-Bq; Mon, 14 Feb 2022 10:42:13 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nJXxe-00EKQs-Qm
 for linux-nvme@lists.infradead.org; Mon, 14 Feb 2022 09:48:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644832076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I2qt3+FoK96nE1glGYDfvHEmytroL36t21/ibFTNEps=;
 b=I3tCx2NzDNA1q6vIs7LOkp2j0mXmFAeGrU/xHQ5uRLC68yPNEZ7NsSULKabC5ywni1SsF4
 dkwcLxbrSo9W43cYZUTK3hMfF86ckJRiISjxKNhkwZF71SOD5RCjNMj6upl2uc0vK0htis
 JR7aKpD+0U+s5lYgjWcPDT7kn63t+RQ=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-116-1NI1PpLPOTWx_6-IDl76Kw-1; Mon, 14 Feb 2022 04:47:54 -0500
X-MC-Unique: 1NI1PpLPOTWx_6-IDl76Kw-1
Received: by mail-pj1-f70.google.com with SMTP id
 ay10-20020a17090b030a00b001b8a4029ba0so13825253pjb.5
 for <linux-nvme@lists.infradead.org>; Mon, 14 Feb 2022 01:47:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=I2qt3+FoK96nE1glGYDfvHEmytroL36t21/ibFTNEps=;
 b=6Fw9I/O+hV4tliCHYQ6t/DoGxYlA9KGpWkkEg1Jucvj5ug5KiCpgiczECvyB9w2Gya
 v63PADeEiHNJGGjcokZu3l1NwSlu9dnIKDh5A1byf8/0x7Stt0yUz/OdA6sn7CdAs0MD
 7wzmSWfyGWcMTPjhOzykkqX1a9lMegPMhB+NHnJS/IEST0QoDuuVYIYGr1pRuLRrkxcb
 7/OzaPE5gVmQ4YGyt2YyY8KbIcEse+4QLm7dXRJu7vZm+EwQZCL0X+KIvWDO8RGAgIsx
 pJE5MfXZAZRcKRM5w4+B+aHAafQs/6VS1S5LNpbW7C3051q4q5n+4bSLNHmmFIj+u6NX
 H2Kw==
X-Gm-Message-State: AOAM530zC59+xWdhcIqiyIGMt8+ktUilkc+QXOnBHBDZ4qHbALvo07XS
 3YBGrv64oHz5Cq4ViaAHVbD5+7UXPPUiiD4MJQWph+EnJcZ16aGBJeMUIcPZqjYevE3U665BDAw
 rjYp7OTIv9jkNnHTm0RNQqe0uq9JNSfy1bONzo7TVGMk=
X-Received: by 2002:a17:90b:4c8e:: with SMTP id
 my14mr303755pjb.71.1644832073355; 
 Mon, 14 Feb 2022 01:47:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwQupS/3/0kv1fHvOOXQWpZzGEaHDzvb3gSL3UfrXE+v/ScWqXHLMS34+5bhifcaRICK6lLTkW+L/Vg/M6cE5Q=
X-Received: by 2002:a17:90b:4c8e:: with SMTP id
 my14mr303737pjb.71.1644832073109; 
 Mon, 14 Feb 2022 01:47:53 -0800 (PST)
MIME-Version: 1.0
References: <CAHj4cs8cT23z+h2i+g6o3OQqEhWnHS88JO4jNoQo0Nww-sdkYg@mail.gmail.com>
 <3c86dc88-97d9-5a71-20e1-a90279f47db5@grimberg.me>
 <CAHj4cs_3eLZd=vxRRrnBU2W4H38mqttcy0ZdSw6uw4KvbJWgeQ@mail.gmail.com>
 <CAHj4cs_VZ7C7ciKy-q51a+Gc=uce0GDKRHNmUdoGOd7KSvURpA@mail.gmail.com>
 <84208be5-a7a9-5261-398c-fa9bda3efbe3@grimberg.me>
 <CAHj4cs8dgNNE5qcX3Y4ykuTYU8z_kea6=q64Pn_2vsdodgOJZQ@mail.gmail.com>
 <CAHj4cs-aDo7DufnKazyKuZVR-1AWr5FK1LDsN=Do=CVUJ2pH3g@mail.gmail.com>
 <9f115198-bafc-be4e-1c90-06444b8a37f6@grimberg.me>
 <CAHj4cs8wBwDGhhtEPodyBdR-sCqJLYhwLhNHuPDm+KCan0hwWg@mail.gmail.com>
 <42ccd095-b552-32f7-96b0-d34d46f7c83e@grimberg.me>
 <CAHj4cs9EazUmtbjPKp5TXO4kRPcSShiYbhmsHwfh7SOTQAeoyw@mail.gmail.com>
 <c6d43a10-44bc-e73a-8836-d75367df049b@grimberg.me>
 <162ec7c5-9483-3f53-bd1c-502ff5ac9f87@nvidia.com>
 <CAHj4cs_kCorBjHcvamhZLBNXP2zWE0n_e-3wLwb-ERfpJWJxUA@mail.gmail.com>
 <3292547e-2453-0320-c2e7-e17dbc20bbdd@nvidia.com>
 <CAHj4cs9QuANriWeLrhDvkahnNzHp-4WNFoxtWi2qGH9V0L3+Rw@mail.gmail.com>
 <fcad6dac-6d40-98d7-93e2-bfa307e8e101@nvidia.com>
 <CAHj4cs_WGP9q10d9GSzKQZi3uZCF+S8qW1sirWZWkkHuepgYgQ@mail.gmail.com>
 <2D31D2FB-BC4B-476A-9717-C02E84542DFA@oracle.com>
 <CAHj4cs-yt1+Lufqgwira-YbB6PHtJ=2JA_Vora_CfarzSzoFrA@mail.gmail.com>
 <4BB6D957-6C18-4E58-A622-0880007ECD9F@oracle.com>
In-Reply-To: <4BB6D957-6C18-4E58-A622-0880007ECD9F@oracle.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Mon, 14 Feb 2022 17:47:40 +0800
Message-ID: <CAHj4cs_ta5WR7j0qvHyr1tSCR-U7=svY5j8Hctd7YUMNcGXsaA@mail.gmail.com>
Subject: Re: [bug report] NVMe/IB: reset_controller need more than 1min
To: Max Gurtovoy <mgurtovoy@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>
Cc: Haakon Bugge <haakon.bugge@oracle.com>, Max Gurtovoy <maxg@mellanox.com>, 
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, 
 OFED mailing list <linux-rdma@vger.kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220214_014759_012568_1740DC8A 
X-CRM114-Status: UNSURE (   7.56  )
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

Hi Sagi/Max
Here are more findings with the bisect:

The time for reset operation changed from 3s[1] to 12s[2] after
commit[3], and after commit[4], the reset operation timeout at the
second reset[5], let me know if you need any testing for it, thanks.

[1]
# time nvme reset /dev/nvme0

real 0m3.049s
user 0m0.000s
sys 0m0.006s
[2]
# time nvme reset /dev/nvme0

real 0m12.498s
user 0m0.000s
sys 0m0.006s
[3]
commit 5ec5d3bddc6b912b7de9e3eb6c1f2397faeca2bc (HEAD)
Author: Max Gurtovoy <maxg@mellanox.com>
Date:   Tue May 19 17:05:56 2020 +0300

    nvme-rdma: add metadata/T10-PI support

[4]
commit a70b81bd4d9d2d6c05cfe6ef2a10bccc2e04357a (HEAD)
Author: Hannes Reinecke <hare@suse.de>
Date:   Fri Apr 16 13:46:20 2021 +0200

    nvme: sanitize KATO setting-

[5]
# time nvme reset /dev/nvme0

real 0m12.628s
user 0m0.000s
sys 0m0.006s
# time nvme reset /dev/nvme0

real 1m15.617s
user 0m0.000s
sys 0m0.006s
#dmesg
[ 1866.068377] nvme nvme0: creating 40 I/O queues.
[ 1870.367851] nvme nvme0: mapped 40/0/0 default/read/poll queues.
[ 1870.370949] nvme nvme0: new ctrl: NQN "testnqn", addr 172.31.0.202:4420
[ 1930.981494] nvme nvme0: resetting controller
[ 1939.316131] nvme nvme0: creating 40 I/O queues.
[ 1943.605427] nvme nvme0: mapped 40/0/0 default/read/poll queues.
[ 1953.708327] nvme nvme0: resetting controller
[ 2024.985591] nvme nvme0: I/O 7 QID 0 timeout
[ 2024.990979] nvme nvme0: Property Set error: 881, offset 0x14
[ 2025.031069] nvme nvme0: creating 40 I/O queues.
[ 2029.321798] nvme nvme0: mapped 40/0/0 default/read/poll queues.


