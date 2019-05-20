From: minwoo.im@samsung.com (Minwoo Im)
Date: Mon, 20 May 2019 13:45:50 +0900
Subject: [PATCH] nvme-cli: close fd before return
In-Reply-To: <BN8PR04MB57478A0FFD0196B2D868AFBF86060@BN8PR04MB5747.namprd04.prod.outlook.com>
References: <BN8PR04MB57478A0FFD0196B2D868AFBF86060@BN8PR04MB5747.namprd04.prod.outlook.com>
 <BN8PR04MB5747CE9613ADDE4BA1D6A5C986060@BN8PR04MB5747.namprd04.prod.outlook.com>
 <BN8PR04MB57474B1D9FD8DC489487336986060@BN8PR04MB5747.namprd04.prod.outlook.com>
 <20190519175642.31815-1-chaitanya.kulkarni@wdc.com>
 <20190519184553.GC10876@minwooim-desktop>
 <20190520002805epcms2p747debe2606f1a42a2b27a6d665f5612d@epcms2p7>
 <20190520015401epcms2p413869afe9728ffc36248cf8e5e00888e@epcms2p4>
 <CGME20190520002113epcas4p345b92c6d82619b92478af81e81392266@epcms2p3>
Message-ID: <20190520044550epcms2p3d9d8631006d1bd63c574c1a92c4e91da@epcms2p3>

> I've not said anything against PR. I was just explaining the idea behind
> sending
> 
> this patch. We can leave it to PR now.
> 
> But this is a good example of having things not be posted on the mailing
> list can
> 
> a create confusion, will be monitoring PR going forward.

Agree with your point.  Actually, recently I'm trying to send patches of nvme-cli
to linux-nvme mailing list, but I'm not sure whether the PR will not be allowed or
not because I'm a just one who contributes this project :)

> So far I've not encountered situation where PRs are being discussed on
> github and
> 
> patch-series is not posted on the mailing list, but it clear to me it
> can create a confusion
> 
> as some people are not following github as closely as mailing list and
> we don't have
> 
> the clarity over which has the priority when it comes to sending patches
> whether it is github or
> 
> the NVMe mailing list.
> 
> From my side, I'll make sure to monitor the PR on github before posting
> any further patches.

Thanks for your support, But I know it's hard to monitor Github PRs all the time.

> I don't mind that in fact I can resend this patch refer to your
> patch-set and mark it
> 
> as a preparation patch with changing title, if PR wasn't in process.

Actually, I'm okay with your patch by making it focused onto something clear.
Anyway, this patch looks good to me in code level, though.

> I've never opposed to fix the leak, but this was not the intent.
> 
> As far as this patch goes, since you are already working on PR with
> github, will retract this
> 
> change and we should go with that change.

Let's see how we can go through it together :)
