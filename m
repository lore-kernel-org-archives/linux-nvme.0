Return-Path: <SRS0=/QSy=NJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0BCC4338F
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Aug 2021 04:57:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C13086109F
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Aug 2021 04:57:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C13086109F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	MIME-Version:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=SuUi1qSBWbHVrupiBCPgyydby5eicrMA10Ed5mucx3E=; b=3Ec
	v6wb4sTAGhu9x9SZ7dxSg22o/0zaAbPBL3RzR79XxRPVU//nU/rN4nbngcTfGf+z+5XPCH9FjcP0n
	AMOnDu20Le1XsDaJBMB8X72pgWQiZAmubOSMgxi6ivxi5jR3/U7aduSgOwin1cYK3MufKSP08q4rC
	7c0QveN/tRvUutMNL5UfeMAOEIl0u3aS0fpuHJ56Qx9MWvM7PaceREiQmQbYl7xwW772k/pKWmoPr
	1ri4KbNBtiCxxYQtJsm25iVmcqu4ZHbmd4EGu7bF1Q1fwIWHp4mNiFQW8lBdnCaqdY4t64XwFxZGP
	hYqsoqFGPrl0JSUIbG0iwd7CCVEPnHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mGDdB-004C8l-90; Wed, 18 Aug 2021 04:56:49 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mGDd7-004C8K-SC
 for linux-nvme@lists.infradead.org; Wed, 18 Aug 2021 04:56:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629262604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=a/ca7BEA4zywbNlK2KoU9IRR3jktn/LpBWXd2WdGoEY=;
 b=fo7u/86kfbfjpJwE0cRxSYSpny4ptu4LZiJ5iCbNHXFM2eQuyWUnwJJBdSJddFXHFelmmZ
 1vahKZTY1MgGxNq3lsKds1Vub5yN9LX7DyNCxI3oLfQ9zcdc/bpKiyVOGvf2dLh3yzhWRi
 GJgaH26lqG/PE5EU+GtfmYIO+Fi3Y+I=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-h4kW_svlMOmeDuUu4S9mJw-1; Wed, 18 Aug 2021 00:56:43 -0400
X-MC-Unique: h4kW_svlMOmeDuUu4S9mJw-1
Received: by mail-yb1-f197.google.com with SMTP id
 s205-20020a252cd6000000b0059449776539so1562760ybs.22
 for <linux-nvme@lists.infradead.org>; Tue, 17 Aug 2021 21:56:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=a/ca7BEA4zywbNlK2KoU9IRR3jktn/LpBWXd2WdGoEY=;
 b=gyVS04VWebED6EnvqNmjfygowrag7ski87b5dkrbRIk1uiUUN+Uranuzgy2EJaRR+g
 24JqvAccxuUfBAFGqM/ah7L1T6pE/eEJuNurqTbTheo7aD9DBJJI8XNn0fGKUD+ZIC7x
 gwv9NiKarsp5Yv9rQ/FzsOlorIAR1rynvAirKlGXTj229qSojM1JpncUPf3X1yYybksO
 S5TMTPQTwVIzxzZqWKYXS+ZwtB6JO4k3+HGn0jBQjvld5sOq1j36DCg/0li9ld3dVseQ
 9ykZ6DWrPh3yAlHSRjXQvaCtqIRYHAwviqEppMd3obQ63lHjM7xkKO+t05dYapFukZd+
 wixw==
X-Gm-Message-State: AOAM533J/g7qS9gILnUKxVQHRuFkrMO2CMsMRddsaSHp8ixbrkVb5Hfc
 wTaRZqepvVXJRGtus1TjugTYMoPA/YkO5ACAHfFSMumCQiRy/YHvDKF1zkPpQ4qORi2ocpw4xlS
 vnNgPDpZh0ZZ9tkGTYbFBNjaMXi3TRqVciuufCCpSsm8=
X-Received: by 2002:a25:4d1:: with SMTP id 200mr8750831ybe.438.1629262602682; 
 Tue, 17 Aug 2021 21:56:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnPbvMDfI7KTTcVzxhPsYLAUb7zwx5zj1jIdjcot+uaRYDFGz8qbqZzzzfuizOgyDgzYqDUGpZLlkIa8wI01o=
X-Received: by 2002:a25:4d1:: with SMTP id 200mr8750824ybe.438.1629262602490; 
 Tue, 17 Aug 2021 21:56:42 -0700 (PDT)
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 18 Aug 2021 12:56:31 +0800
Message-ID: <CAHj4cs_M_PJ-7U3QdUxG5=Ce56mBP+WUwko2JqBO6gu_3CqJwQ@mail.gmail.com>
Subject: [bug report] rdma_rxe doesn't work with blktests on 5.14.0-rc6
To: linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210817_215646_026598_ED7D1A91 
X-CRM114-Status: UNSURE (   8.89  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hello

I found rdma_rxe doesn't work with blktests on the latest upstream, is
it a known issue, feel free to let me know if you need any info/test
for it, thanks.

# nvme_trtype=rdma ./check nvme/008
nvme/008 (create an NVMeOF host with a block device-backed ns) [failed]
    runtime  0.323s  ...  0.329s
    --- tests/nvme/008.out 2021-08-18 00:18:35.380345954 -0400
    +++ /root/blktests/results/nodev/nvme/008.out.bad 2021-08-18
00:35:11.126723074 -0400
    @@ -1,5 +1,7 @@
     Running nvme/008
    -91fdba0d-f87b-4c25-b80f-db7be1418b9e
    -uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
    -NQN:blktests-subsystem-1 disconnected 1 controller(s)
    +Failed to write to /dev/nvme-fabrics: Cannot allocate memory
    +cat: '/sys/class/nvme/nvme*/subsysnqn': No such file or directory
    +cat: /sys/block/n1/uuid: No such file or directory
    ...
    (Run 'diff -u tests/nvme/008.out
/root/blktests/results/nodev/nvme/008.out.bad' to see the entire diff)


[  981.382774] run blktests nvme/008 at 2021-08-18 00:33:21
[  981.470796] rdma_rxe: loaded
[  981.474338] infiniband eno1_rxe: set active
[  981.474340] infiniband eno1_rxe: added eno1
[  981.476737] eno2 speed is unknown, defaulting to 1000
[  981.481803] eno2 speed is unknown, defaulting to 1000
[  981.486865] eno2 speed is unknown, defaulting to 1000
[  981.492862] infiniband eno2_rxe: set down
[  981.492864] infiniband eno2_rxe: added eno2
[  981.492904] eno2 speed is unknown, defaulting to 1000
[  981.497957] eno2 speed is unknown, defaulting to 1000
[  981.504338] eno2 speed is unknown, defaulting to 1000
[  981.510442] eno3 speed is unknown, defaulting to 1000
[  981.515509] eno3 speed is unknown, defaulting to 1000
[  981.520580] eno3 speed is unknown, defaulting to 1000
[  981.526600] infiniband eno3_rxe: set down
[  981.526601] infiniband eno3_rxe: added eno3
[  981.526640] eno3 speed is unknown, defaulting to 1000
[  981.531693] eno3 speed is unknown, defaulting to 1000
[  981.538052] eno2 speed is unknown, defaulting to 1000
[  981.543115] eno3 speed is unknown, defaulting to 1000
[  981.549088] eno4 speed is unknown, defaulting to 1000
[  981.554149] eno4 speed is unknown, defaulting to 1000
[  981.559211] eno4 speed is unknown, defaulting to 1000
[  981.565201] infiniband eno4_rxe: set down
[  981.565203] infiniband eno4_rxe: added eno4
[  981.565242] eno4 speed is unknown, defaulting to 1000
[  981.570306] eno4 speed is unknown, defaulting to 1000
[  981.576724] eno2 speed is unknown, defaulting to 1000
[  981.581785] eno3 speed is unknown, defaulting to 1000
[  981.586848] eno4 speed is unknown, defaulting to 1000
[  981.599312] loop0: detected capacity change from 0 to 2097152
[  981.612261] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  981.614215] nvmet_rdma: enabling port 0 (10.16.221.116:4420)
[  981.622586] nvmet: creating controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0035-4b10-8044-b9c04f463333.
[  981.622830] nvme nvme0: creating 32 I/O queues.
[  981.634860] nvme nvme0: failed to initialize MR pool sized 128 for
QID 32         ----------------------- failed here
[  981.772647] eno2 speed is unknown, defaulting to 1000
[  981.641676] nvme nvme0: rdma connection establishment failed (-12)
[  981.777715] eno3 speed is unknown, defaulting to 1000
[  981.782780] eno4 speed is unknown, defaulting to 1000
[  981.799443] rdma_rxe: unloaded

--
Best Regards,
  Yi Zhang


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
