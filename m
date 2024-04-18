Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F5FC4345F
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Apr 2024 21:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:Cc:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LcAoBKAI7vXpok1np6pDDCvua3mPGNrzWsBaH3kEBYs=; b=VPU/giE9wviBdrBO5+rTz5YoXl
	4gZ2fVXz+OxckVXOAWaxMlExFW21OyVAjylvsxiAT1l77T/vOVFSVmlinh72W1aogo0Qt529homLO
	/FqCT5fmMRdA3Bp9bZq9WeIGpIA7I5Em26wdflGT5iL2OUWMWBft6EozwAaby189wwgOGi4iCEfTk
	1/L0/zjv+U5Ch4x8gc8Xu4z/46klwSRomSk87p6J90saAvmHEv5AFYPciCw40/0gOBe5qMeby7g0O
	lqTQmMDLEqbNoZsQXpBLrpPpv6DVoEgg19FEvumSF+JoytAXxFU/dBJqmP156i900yFddpVaVsy6c
	53ZtCpJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxZfy-00000003md3-10cy;
	Thu, 18 Apr 2024 21:52:14 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxZfu-00000003mcT-1sTP
	for linux-nvme@lists.infradead.org;
	Thu, 18 Apr 2024 21:52:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713477121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LcAoBKAI7vXpok1np6pDDCvua3mPGNrzWsBaH3kEBYs=;
	b=QLW7liEgg5KUxYjhIw/pMmhZUJBHTDxlMjqv6V/ED9pNwkZcIPH0KqZp1Z2z4t83lru1Cl
	5b7krSwMwJR+HwFKy2rDh2L2nuyERiszRfbqgoWNUiHhAEjCbCq7/P3b//PHCsGA/EVmbb
	LIUm/p51SrRiwdNqMjK/xHjW9SiBHfI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-IQU_lp8SMPSDgBSfB1YVJA-1; Thu,
 18 Apr 2024 17:48:42 -0400
X-MC-Unique: IQU_lp8SMPSDgBSfB1YVJA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 18F193810D35;
	Thu, 18 Apr 2024 21:48:42 +0000 (UTC)
Received: from [10.18.25.182] (unknown [10.18.25.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 724442166B32;
	Thu, 18 Apr 2024 21:48:41 +0000 (UTC)
Message-ID: <04c77907-073a-4adf-8a6a-a2b3af28a853@redhat.com>
Date: Thu, 18 Apr 2024 17:48:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] fabrics: Always pass hostid and hostnqn
To: Israel Rukshin <israelr@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 Linux-nvme <linux-nvme@lists.infradead.org>, Sagi Grimberg
 <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
References: <1713450277-20323-1-git-send-email-israelr@nvidia.com>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
Cc: Ewan Milne <emilne@redhat.com>, Tomas Bzatek <tbzatek@redhat.com>,
 "Farley, Douglas" <Douglas.Farley@dell.com>,
 "Ballard, Curtis C (HPE Storage)" <curtis.ballard@hpe.com>,
 Frederick Knight <Frederick.Knight@kioxia.com>,
 James Smart <james.smart@broadcom.com>
In-Reply-To: <1713450277-20323-1-git-send-email-israelr@nvidia.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240418_145210_612898_21C12F05 
X-CRM114-Status: GOOD (  48.92  )
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

On 4/18/24 10:24, Israel Rukshin wrote:
> After the kernel commit ae8bd606e09b ("nvme-fabrics: prevent overriding
> of existing host"), kernel ensures hostid and hostnqn maintain 1:1
> mapping. This makes 'nvme discover' and 'nvme connect' commands fail
> when providing only hostid or only hostnqn. This issue happens when
> the user only enters NQN which doesn't contain UUID, so the generation
> of the hostid fails.
There are two TPs that I want to call attention to in considering these patches.

The first is TP-4110 Align Fabrics and PCIe Host Identifier Setting.

 From TP-4110: this is requirement for the controller.

  A Host Identifier value of 0h indicates that the host associated with the controller is not associated with any
  other controller in the NVM subsystem. For example, two controllers in an NVM subsystem that both have
  a Host Identifier value of 0h indicates that the controllers are associated with different hosts. NVMe over
  PCIe implementations may support using a Host Identifier value of 0h for the reservations feature (refer to
  section 8.19). However, reservations and registrations associated with a Host Identifier value of 0h do not
  persist across a Controller Level Reset since a host that uses a Host Identifier value of 0h is treated as a
  different host after a Controller Level Reset.

  A Set Features command should be used to change a Host Identifier value of 0h to a non-zero value before
  using streams (refer to section 8.7.3) or using reservations (refer to section 8.19). Information (i.e., streams
  or reservations) associated with a Host Identifier value of 0h retain the association to that Host Identifier if
  the Host Identifier value is changed and are not associated with the host that has the non-zero Host
  Identifier.

  The NVM subsystem indicates if reservations are supported with a Host Identifier value of 0h with the RHII
  bit in the Controller Attributes field of the Identify Controller data structure (refer to figure 275). The NVM
  subsystem indicates if streams are supported with a Host Identifier value of 0h with the SRNZID bit in the
  NVM Subsystem Stream Capability field of the streams directive return parameters (refer to Figure 425).

Basically, we want to allow all Fabric hosts to connect with HostID == 0. This TP was ratified to bring nvme-pci and nvme-of 
into alignment. Note that this is a requirement for the NVMe Controller, not the Host... but how do the changes for kernel 
commit ae8bd606e09b ("nvme-fabrics: prevent overriding of existing host") and these changes to nvme-cli bring us closer to 
supporting what the spec says we "should" support with the hostid?

There is also TP-4126 NVMe-oF Boot HostNQN and HostID. This is a requirement for the host.

  The pre-OS boot environment and OS environment should use a fixed platform UUID to create a HostNQN
  and HostID. The implementation should use the System UUID found in the SMBIOS table. The System
  Management BIOS (SMBIOS) Reference Specification is described in DSP0134. The SMBIOS table is
  typically available to pre-OS firmware and Expansion ROM Firmware in the pre-OS boot environment as
  well as to the OS environment.

You need to be aware that, before TP-4126, there was no requirement in the NVMe spec for what the HostNQN needs to be outside of 
Section 4.5 of the NVMexpress Base Specification v2.0. According to Section 4.5 the NVMe Qualified Names come in two supported 
NQN formats. The first format may be used by any organization that owns a domain name. E.g.:

nqn.2019-10.com.kioxia:KCM6XVUL1T60:72F0A01DTC88

This format is most often used as a subsystem NQN, but there is nothing in the spec that requires that (before TP-4126) so there 
are legacy systems out there that can and do use this first format for the hostnqn as well. E.g.:

nqn.1988-11.com.dell:PowerEdge.R660.8DD0DX3

The second format is a vendor nuetral format. The second format may be used to create a unique identifier when there is not a 
naming authority or there is not a requirement for a human interpretable string. E.g.:

nqn.2014-08.org.nvmexpress:uuid:f81d4fae-7dec-11d0-a765-00a0c91e6bf6

This is the format that we have opted to use in in Linux for the HostNQN, but there is nothing requiring this (before TP-4126) 
in the NVMe specification.

So my concern here is: backwards compatibility. I am concnerned that scrictly enforcing policies that are not in the spec - 6 
years after the introduction of the nvme-of protocol - will break something.

I also think forcing the host to use a specific Host ID with the connect command is a mistake and a potential violation of the 
NVMe specification (ala TP-4110).

> There are few more issues that this commit is fixing:
>   - When the user provides hostid and NQN, the hostid is overridden
>     by generating it from the NQN.
>   - hostid is generated from the NQN file instead of the NQN that
>     the user enters at the command line.

We actually depend upon this "defect" to allow backwards compatibility in RHEL. In RHEL 9.2 the nvme-cli.rpm install script 
would generate a /etc/nvme/hostid and hostnqn file as a part of the rpm install. The hostnqn is generated using the `nvme 
gen-hostnqn` command but the hostid was generated with a random UUID.  This was complaint with the spec until TP-4126 came along.

So, to insure that our RPM install doesn't create a HostID in conflict with any future Boot Firmware we changed the RHEL rpm 
install procedure to generate a hostid based upon the System UUID.  This is what nvme-cli does now too... so that's not a 
problem.  However, for hosts that installed RHEL-9.2 and then upgraded to 9.4 - we need the current nvme-cli utility "feature" 
that allows overridding the host-id with what's in /etc/nvme/hostid.  I don't want to remove that functionality because it 
supports non-distruptive upgrade in cases where the /etc/nvme/hostid and hostnqn file is preserved during the host OS upgrade.

>   - The warning "use generated hostid instead of hostid file" is
>     wrong when the user provides hostid via the command line.

Yes. this message has been incorrect. I agree is should be fixed.

> The commit fixes those issues by doing the following logic:
>   1. If user provided both via command line - pass them as-is
>   2. If user doesn't enter them via command line - try to get
>      them from files.
>   3. If one of them is not provided - generate it from the other.
>      Use the new functions nvmf_hostid_generate() when NQN doesn't
>      have UUID and use nvmf_hostnqn_generate_from_hostid(hostid) to
>      generate hostnqn from hostid.
>   4. If user provided none - generate them both. Before this commit,
>      nvme cli didn't do it.

I agree these changes are needed. I will take a closer look at the patch.  As long as we allow the use case where the user can 
override the auto-generated hostnqn and hostid created in nvme-cli by passing the needed hostid and hostnqn from /etc/nvme or on 
the command line, I'm good.  We need to be aware that there are a number of legacy NVMe-oF fabrics out there that are already 
provisioned with different hostnqns and hostids and we can't be breaking backwards compatibility with these running systems.

/John

> Signed-off-by: Israel Rukshin <israelr@nvidia.com>
> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
> 
> Changes from v1:
>   - Fix comments of Daniel Wagner and update commit message accordingly.
>     Use nvmf_hostnqn_generate_from_hostid() and use local variables
>     at nvmf_set_hostid_and_hostnqn().
> 
>   fabrics.c | 78 ++++++++++++++++++++++++++++++++-----------------------
>   1 file changed, 46 insertions(+), 32 deletions(-)
> 
> diff --git a/fabrics.c b/fabrics.c
> index 871c20ed..0b70d290 100644
> --- a/fabrics.c
> +++ b/fabrics.c
> @@ -643,20 +643,9 @@ char *nvmf_hostid_from_hostnqn(const char *hostnqn)
>   
>   void nvmf_check_hostid_and_hostnqn(const char *hostid, const char *hostnqn, unsigned int verbose)
>   {
> -	_cleanup_free_ char *hostid_from_file = NULL;
>   	_cleanup_free_ char *hostid_from_hostnqn = NULL;
>   
> -	if (!hostid)
> -		return;
> -
> -	hostid_from_file = nvmf_hostid_from_file();
> -	if (hostid_from_file && strcmp(hostid_from_file, hostid)) {
> -		if (verbose)
> -			fprintf(stderr,
> -				"warning: use generated hostid instead of hostid file\n");
> -	}
> -
> -	if (!hostnqn)
> +	if (!hostnqn || !hostid)
>   		return;
>   
>   	hostid_from_hostnqn = nvmf_hostid_from_hostnqn(hostnqn);
> @@ -667,6 +656,34 @@ void nvmf_check_hostid_and_hostnqn(const char *hostid, const char *hostnqn, unsi
>   	}
>   }
>   
> +void nvmf_set_hostid_and_hostnqn(char **hostid, char **hostnqn)
> +{
> +	char *hid = *hostid;
> +	char *hnqn = *hostnqn;
> +
> +	if (!hid)
> +		hid = nvmf_hostid_from_file();
> +	if (!hnqn)
> +		hnqn = nvmf_hostnqn_from_file();
> +
> +	if (!hid) {
> +		if (hnqn) {
> +			hid = nvmf_hostid_from_hostnqn(hnqn);
> +			if (!hid)
> +				hid = nvmf_hostid_generate();
> +		} else {
> +			hid = nvmf_hostid_generate();
> +			hnqn = nvmf_hostnqn_generate_from_hostid(hid);
> +		}
> +	}
> +
> +	if (!hnqn)
> +		hnqn = nvmf_hostnqn_generate_from_hostid(hid);
> +
> +	*hostid = hid;
> +	*hostnqn = hnqn;
> +}
> +
>   int nvmf_discover(const char *desc, int argc, char **argv, bool connect)
>   {
>   	char *subsysnqn = NVME_DISC_SUBSYS_NAME;
> @@ -746,16 +763,13 @@ int nvmf_discover(const char *desc, int argc, char **argv, bool connect)
>   
>   	hostnqn_arg = hostnqn;
>   	hostid_arg = hostid;
> -	if (!hostnqn)
> -		hostnqn = hnqn = nvmf_hostnqn_from_file();
> -	if (!hostnqn) {
> -		hostnqn = hnqn = nvmf_hostnqn_generate();
> -		hostid = hid = nvmf_hostid_from_hostnqn(hostnqn);
> -	}
> -	if (!hostid)
> -		hostid = hid = nvmf_hostid_from_file();
> -	if (!hostid && hostnqn)
> -		hostid = hid = nvmf_hostid_from_hostnqn(hostnqn);
> +
> +	nvmf_set_hostid_and_hostnqn(&hostid, &hostnqn);
> +	if (!hostid_arg)
> +		hid = hostid;
> +	if (!hostnqn_arg)
> +		hnqn = hostnqn;
> +
>   	nvmf_check_hostid_and_hostnqn(hostid, hostnqn, verbose);
>   	h = nvme_lookup_host(r, hostnqn, hostid);
>   	if (!h) {
> @@ -905,6 +919,7 @@ int nvmf_connect(const char *desc, int argc, char **argv)
>   	enum nvme_print_flags flags;
>   	struct nvme_fabrics_config cfg = { 0 };
>   	char *format = "normal";
> +	char *hostnqn_arg, *hostid_arg;
>   
>   
>   	NVMF_ARGS(opts, cfg,
> @@ -972,16 +987,15 @@ int nvmf_connect(const char *desc, int argc, char **argv)
>   	nvme_read_config(r, config_file);
>   	nvme_read_volatile_config(r);
>   
> -	if (!hostnqn)
> -		hostnqn = hnqn = nvmf_hostnqn_from_file();
> -	if (!hostnqn) {
> -		hostnqn = hnqn = nvmf_hostnqn_generate();
> -		hostid = hid = nvmf_hostid_from_hostnqn(hostnqn);
> -	}
> -	if (!hostid)
> -		hostid = hid = nvmf_hostid_from_file();
> -	if (!hostid && hostnqn)
> -		hostid = hid = nvmf_hostid_from_hostnqn(hostnqn);
> +	hostnqn_arg = hostnqn;
> +	hostid_arg = hostid;
> +
> +	nvmf_set_hostid_and_hostnqn(&hostid, &hostnqn);
> +	if (!hostid_arg)
> +		hid = hostid;
> +	if (!hostnqn_arg)
> +		hnqn = hostnqn;
> +
>   	nvmf_check_hostid_and_hostnqn(hostid, hostnqn, verbose);
>   	h = nvme_lookup_host(r, hostnqn, hostid);
>   	if (!h) {


