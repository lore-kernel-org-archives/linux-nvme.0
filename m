Return-Path: <SRS0=EFt+=KE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB733C433ED
	for <linux-nvme@archiver.kernel.org>; Sun,  9 May 2021 02:30:31 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26F3360234
	for <linux-nvme@archiver.kernel.org>; Sun,  9 May 2021 02:30:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26F3360234
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=yahoo.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:MIME-Version:In-Reply-To:References:To:
	Subject:From:Date:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=913cqBpshqHP5oeyyeYE3y5Z9nY9GSEObcvo+nrNII4=; b=DWlEvbg7Xhs7bPZh1kHaO5UtT
	T7RzIiNdl4p1ejC0gobZb2KjtDTXOGQ/GT6ScavcXJKpuLdC0+47QbAqHbqJxmf2c9pv5jBbB+qq8
	KuQ0Kj3Xf+rSNLFEtKnfOfgcQphxmRrTPWexLPSQusQnU6iNkruL55rknCsubQWieCSAm6+VLIXpl
	TmtD1MaCzCRj63R/RV+h1VG8wGTS0rV650mpoxK3Hl7VAO9b6tfcDdmlHdmmYOglUtqzG+RdtSqRj
	YS+W8hiVGsUFYb0VwYnQ1OgGPlT92Lpu+VlqOs1MVLJYED/IL76w0q3BlptcRgV6XdAIKnKrCkQPN
	SLNtb9xmg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lfZCu-00AnPM-Ve; Sun, 09 May 2021 02:30:13 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lfZCp-00AnP6-Fr
 for linux-nvme@desiato.infradead.org; Sun, 09 May 2021 02:30:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:Message-Id:MIME-Version:In-Reply-To:References:To:Subject:From:
 Date:Sender:Reply-To:Cc:Content-ID:Content-Description;
 bh=ueIl4x8R37izX0Gh+GlY985UzorU1ofhHJDIzVNG++Q=; b=UOjLMUyWbhysEAq1H0a2JUbqF+
 YszhC3KIPNMw5OrwX+mp38ZHvkqBfJzgcr3XpngbJf2tQCJ5hRtZbBh4vYsG2J8Hmakz+Z9mxA4yo
 O3K+yaQzdbCW2ROrI0SKO+RuetFVAMhvxvgZnSBhisb8tg/CQk2by/HShTTYsAundl0JD9tlb83w+
 CtTOaE8HUV/cdVjatjucNZyLtbNiv6GY6u+jtf/SbnwOKbvk866MGbPUwly6qQB3I41qV9Qv0WMr7
 u0Ib6S6GOYRY2Il4YmTH9da/P/sBrzDtV0X9+y7ucoGXPwH32TFxWjkUh+lUlIzN/44KHdmJaDzwz
 08jur9vA==;
Received: from sonic315-55.consmr.mail.gq1.yahoo.com ([98.137.65.31])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lfZCm-007og2-Pk
 for linux-nvme@lists.infradead.org; Sun, 09 May 2021 02:30:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048;
 t=1620527402; bh=ueIl4x8R37izX0Gh+GlY985UzorU1ofhHJDIzVNG++Q=;
 h=Date:From:Subject:To:References:In-Reply-To:From:Subject:Reply-To;
 b=sTD95D4gy+Vcqfdm9MRrhFLgK+32S9AeoOouq63VuJwOeCGgOXgTCc6ELOHmStNbQFexs593GFDvf8atd99OtINT/E1CkDbj3aAMsffzYZhgK2cIAqRNZa7/W2tYO1Z3GyZRYosld+QNZUskmsb/P3bpWdMAPNF30Sp2wx/voRu+HETrknMnipBL7lXkUeY+B9uTLy2EXrcUv3RYLzN5X6sZ0hi7v8Gh6G7Si7KyRUBfP3jkgFBawinR9tAD7DLMarj/Z5QM+Dbuft553zk0UD8b3Sj4gyXMlKWUDc3z8uSxNupXKQj39f9F2rIJqpwooByxjodos/UrT95rxqZvmA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1620527402; bh=Ksi/3rA1jmDcJr2jceaBfwpzHRN06fYLNlpsY0Ymy7E=;
 h=X-Sonic-MF:Date:From:Subject:To:From:Subject;
 b=l1TdtQVEneOnH5uyPqMeqcaFb6SjQW2moX2VGCQXiarSVzMYTPhAStSNyR4yiMw9pjVHuA9qJNUqNkOoRKS1JRyBRkZVpqRpwnTHONB7AmCQL/8JcgmvpOBly7D2Jlwx727ms0/4XeZZFSp0aX908XqhdEU4k0aQPk1b/ZMh/cjWqTv1VWKHGMnYkHi77ZbjSbrsaGCBLIiB0dVqWg/BE45WUNbw3mn1iWKafFQRPin4TOSuucXmM3jD5xjw3ZE+yjBrrQ+b5NBDoM5q36Im/vRwHchOG67aF34n1ESlT73FSQSaE6OuFsS/Fmus3CigDkj/PiV01SXlUOaNavxlDg==
X-YMail-OSG: EgeiaXkVM1mD0vvW4oDu7C7lIv8_9b2iJCYw9gEGiBLiPrYE9JNtm4DHccbo60j
 Hr7qW.0bzv9MKlY0G0fj6O7Y7gOgLjHvM_Y8U77LjGISal8B62Ti5O2zpmN5GTZLzjTslfrZTQf_
 H508yT.PwsypXm66QCn.SZ1.gKl4kydeOftY4Iom9cZKZ_Rq8Y7_nCAMzoJrBHQ.BqKt2_f6DSC6
 7hTUiIKn90vnW3.CuLuo.a0dphl9IXc4y0uCKyqL7AWwxkT5k.36FQjinPxUOpzcUlEXoGYLHIOC
 icJ2uzHXNpsOkE9nQnOZ7lZUu.VcTbEESvfK1DjB.BC_ykwgcqcXTSET7yV8B5Dj4xhV6zHYwpzN
 gKs3H4qNk7pWfZvqxjWtSADVZxqFCMYy2bFYqTbCh0B7f_n4qj5SDeN74VisyR0kF0acOfYf1SbH
 vkTuSMsvtGA_yS.2B.EfXB15HnoEZ9.4iKDdVRpJlNpsTqFjruQez1Pil2K_4qV2PYRIAUsC3gMh
 P0zYzlJZZ4_Vwytw0G4HCeKBAc2W5HyTjp90OvBwwBR2CoE92Pl_SacyguvxLYptVjPoJPGSnotF
 qa12AGmoTcuRdjpevTTJ4.GqGEyFfKHdP99C8aWUS2bJKSq2pM049..npyEoFWjgI00I9zH7CHef
 o9G5AoVxnDio6xM9QZveKEp8zsPlhwa6JQ1GJwIyGvHN_uiKi_Ym.fCWUMzkOrY52_QVTJHF_Dax
 cWju2DqRKonKWi_SN8wGynu4kmhSziHc5R6ZJoMJ.riw4FiQY0etdfQIUh98bIU2iIBpEgfhw4R0
 wJ2MrdrjTct6YuZb_X_Ix2bTeeDfpzrWSrXL9vBBSRw.duG6f026iVB9rROPJTJlkqTQ57xT4RBA
 TrDhqlAr__0YL9Ojgkq0tFtHHvIGpb2W.jN6.pClT6OxKNnuwtYn2kSBq_l1y8PmlKURSvWCqOGR
 MNVDHcOqWaQT8EVE_T85QB.lBQ6fr.ccF4po8Hv73QZwlOKTxV4RDxecQmN2AnGd85b46.2e9YFp
 WZyJGFlJ4y_n8wghA9ZmccDRAwXj1026KWqIb_kq2cavJNHoLhbkwbVp5aSbt4x6i3UHlQaWWC.8
 m2WPH4ryk0cr0zdzTQsIJ9IJQrurmOQHDdKJllz9hN3OoyiaYn2VFShK.xjtWKVxrtc01Kd8Yvcf
 gK3JHxNhljc0ugoIuPqSI6g1i4YmV95M9Vd4oW910V080GtqQeL70rp1ow6eRjhoGBis_4tEkSe3
 TgAHp6nnjYLkgq_1PcVGzKkibDoxHysGQIOR5eqaR9A7sULmqmS2ZUQBx5RuCcKaTMHW_mIT7AGq
 QtEWK.DcchvrvpPYeC9QC4Y_QLNmCClK80a1yCKU0s0KvL.7Dgv.PTPCH09EEAbF54nTN654f2_c
 _NOw_KV7J22ddj6fjpCvCYe6XsNUOqO8kaCAsa040fFnv5xmUUKl4XK.DQIj7KDqt6QH68XF6I_o
 f9yFe95r3Nv7vgR5NCGZ3iBJoW1Y1xFsnDgjAqYEZFKIF_9hsVQM981JiipT67B0OqdWgK5.BhYC
 RtZRLGSXM_IT_zvno07Q7VHlFH0XbQlH7U.qnj_0WyjWrBU2hdS2xI2DmRTdISeQFHfrZZL2f3lc
 916OZExxq7qBe5GnFdZj.5UW8EdXINRgC4Drsh74HCZIXeDF4StYaLs65AnrlCi5pl8ur2JSmJyb
 w.VGcJJFJ.uscHFOlueZbb5ulYN45UAMAA04MsTWSf_XI0gpDSCpzeovN5q74bwUnSwJQoe5vNX_
 XSaE.Ke3jIwkHpXx07udRNp4LW6svFDn7HXBvFE5R8gfTPC2HoBfAM0yDYBBtvdXRvOqVKmK5Op8
 DiN35YtBjkTwViFUV6_jejbyhaUerqNzU6YkjBjhKs.UIs8VV1SgIEecGZ2KNVPyj3ElwTBK4ccf
 8VNMRY8ZA46cRtJbrz72n5kyLVWzBoAWmRGL_AVSQ.b2kWMd5APU0Lte2hIYQ88ROoLIXH74TCHr
 IUA9ekI5hESNV05fz4lyPVeE_zI8n4x7oEWQQkX1_MV8KOb5W6ZbPk.GU_Z38SaSU5FZHplokOWe
 pn3HEOk10PheR8gogz5U569vxiyDVS6QuVuIZWuYwLplPJgg7Plqjw7PhqGn8yfE1z_3rskUBeuA
 BCYPb3JIKEMgomHY4p.vgsd901NBy8Vxy15rxXdFZWBiAaLbdZwADPLPydVAfJsEn_j3hRRuanuq
 vzv6lUj6ESvkjgFde6HMB1weNidOK0muCFT6BBvA_5mEcn9tVxmGSIZtVkOrHVRmqD1gRs0kWO4q
 xuwlHkMVqt1nImX048wubdy_kGFmAkvswbf0B_E2L9pd1LhDXxXcXUVjLLu9tI2rhkWGF9TcGvSV
 c3IB6ao33ge3pTqwj2B5NFnZX1VRr4TuByCbDVWav8cZD7Dqh4tryiuIVDbSooHb8qZ5Pm4IF2MG
 kla.uUIbI2PZTBk7FVM33BJ8sqhtXaIlK2FBCV0hIqQRlzXyXTQwDSRA6AOGjM5hmsvXp0d0ZW58
 _MlM0vtsremlHfHZRncsCCKuPkTvsqWlCBxwMZd8rEXKp.mJi1ptZWfGRt5P5bp3Qy4uigMm5Ssf
 hlmz84befS5qfZgb0ochSbn9NHxhJlEAccDIZygamDW0zZwSYopV58FBKZI4sSydeX.PYiQ0KUW4
 dgSsev.ifJXe2ZOihZ7_4tj7IUdkgb1MwDiGVk4qyOcdWJ0eQoKys456W_uGuosle.GUbPxg1aQD
 NNukk94TvpwgwGV1k.P3bBPHDSE9aJTDa1Pjpyz_KdC2bygVz0qxaEzaoWjbtYPVrs4Cfw_88c5n
 9vlPeulAjLl2qcU86wpunZtMg4mjTle_OPYMfZUs-
X-Sonic-MF: <alex_y_xu@yahoo.ca>
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic315.consmr.mail.gq1.yahoo.com with HTTP; Sun, 9 May 2021 02:30:02 +0000
Received: by kubenode569.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP
 Server) with ESMTPA ID f2d11dc1d343c0ca0261cac91088d59a; 
 Sun, 09 May 2021 02:30:00 +0000 (UTC)
Date: Sat, 08 May 2021 22:29:57 -0400
From: "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: Re: regression: data corruption with ext4 on LUKS on nvme with
 torvalds master
To: linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
 dm-crypt@saout.de, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, Changheun Lee
 <nanich.lee@samsung.com>, bvanassche@acm.org, yi.zhang@redhat.com,
 ming.lei@redhat.com, bgoncalv@redhat.com, hch@lst.de, jaegeuk@kernel.org
References: <1620493841.bxdq8r5haw.none@localhost>
In-Reply-To: <1620493841.bxdq8r5haw.none@localhost>
MIME-Version: 1.0
Message-Id: <1620526887.tg1zx7w5np.none@localhost>
X-Mailer: WebService/1.1.18231
 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
 Apache-HttpAsyncClient/4.1.4 (Java/16)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210508_193004_887823_ECE6EBCD 
X-CRM114-Status: GOOD (  15.09  )
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

Excerpts from Alex Xu (Hello71)'s message of May 8, 2021 1:54 pm:
> Hi all,
> 
> Using torvalds master, I recently encountered data corruption on my ext4 
> volume on LUKS on NVMe. Specifically, during heavy writes, the system 
> partially hangs; SysRq-W shows that processes are blocked in the kernel 
> on I/O. After forcibly rebooting, chunks of files are replaced with 
> other, unrelated data. I'm not sure exactly what the data is; some of it 
> is unknown binary data, but in at least one case, a list of file paths 
> was inserted into a file, indicating that the data is misdirected after 
> encryption.
> 
> This issue appears to affect files receiving writes in the temporal 
> vicinity of the hang, but affects both new and old data: for example, my 
> shell history file was corrupted up to many months before.
> 
> The drive reports no SMART issues.
> 
> I believe this is a regression in the kernel related to something merged 
> in the last few days, as it consistently occurs with my most recent 
> kernel versions, but disappears when reverting to an older kernel.
> 
> I haven't investigated further, such as by bisecting. I hope this is 
> sufficient information to give someone a lead on the issue, and if it is 
> a bug, nail it down before anybody else loses data.
> 
> Regards,
> Alex.
> 

I found the following test to reproduce a hang, which I guess may be the 
cause:

host$ cd /tmp
host$ truncate -s 10G drive
host$ qemu-system-x86_64 -drive format=raw,file=drive,if=none,id=drive -device nvme,drive=drive,serial=1 [... more VM setup options]
guest$ cryptsetup luksFormat /dev/nvme0n1
[accept warning, use any password]
guest$ cryptsetup open /dev/nvme0n1
[enter password]
guest$ mkfs.ext4 /dev/mapper/test
[normal output...]
Creating journal (16384 blocks): [hangs forever]

I bisected this issue to:

cd2c7545ae1beac3b6aae033c7f31193b3255946 is the first bad commit
commit cd2c7545ae1beac3b6aae033c7f31193b3255946
Author: Changheun Lee <nanich.lee@samsung.com>
Date:   Mon May 3 18:52:03 2021 +0900

    bio: limit bio max size

I didn't try reverting this commit or further reducing the test case. 
Let me know if you need my kernel config or other information.

Regards,
Alex.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
