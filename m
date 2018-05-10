From: christian.koenig@amd.com (=?UTF-8?Q?Christian_K=c3=b6nig?=)
Date: Thu, 10 May 2018 14:52:46 +0200
Subject: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
In-Reply-To: <4e0d0b96-ab02-2662-adf3-fa956efd294c@deltatee.com>
References: <20180423233046.21476-5-logang@deltatee.com>
 <20180507231306.GG161390@bhelgaas-glaptop.roam.corp.google.com>
 <e58e8d27-42a5-ca69-3b68-c409a2922cd1@amd.com>
 <0b4183ef-e720-204b-9e85-b9eaf7a4136a@deltatee.com>
 <a943a92d-15cd-fb2d-21c3-5e5cfccd9eff@amd.com>
 <3584a6ac-95c7-5d23-1859-aee30605776e@deltatee.com>
 <20180508133407.57a46902@w520.home>
 <5fc9b1c1-9208-06cc-0ec5-1f54c2520494@deltatee.com>
 <20180508141331.7cd737cb@w520.home>
 <d70cf286-f7b7-99a5-1042-022506298fed@deltatee.com>
 <20180508205005.GC15608@redhat.com>
 <7FFB9603-DF9F-4441-82E9-46037CB6C0DE@raithlin.com>
 <a1a36f88-fbfb-b5ee-6dcb-5c5bb96132dd@amd.com>
 <4e0d0b96-ab02-2662-adf3-fa956efd294c@deltatee.com>
Message-ID: <2fc61d29-9eb4-d168-a3e5-955c36e5d821@amd.com>

Am 09.05.2018 um 18:45 schrieb Logan Gunthorpe:
>
> On 09/05/18 07:40 AM, Christian K?nig wrote:
>> The key takeaway is that when any device has ATS enabled you can't
>> disable ACS without breaking it (even if you unplug and replug it).
> I don't follow how you came to this conclusion...
>   The ACS bits we'd be turning off are the ones that force TLPs addressed
> at a peer to go to the RC. However, ATS translation packets will be
> addressed to an untranslated address which a switch will not identify as
> a peer address so it should send upstream regardless the state of the
> ACS Req/Comp redirect bits.

Why would a switch not identify that as a peer address? We use the PASID 
together with ATS to identify the address space which a transaction 
should use.

If I'm not completely mistaken when you disable ACS it is perfectly 
possible that a bridge identifies a transaction as belonging to a peer 
address, which isn't what we want here.

Christian.

>
> Once the translation comes back, the ATS endpoint should send the TLP to
> the peer address with the AT packet type and it will be directed to the
> peer provided the Direct Translated bit is set (or the redirect bits are
> unset).
>
> I can't see how turning off the Req/Comp redirect bits could break
> anything except for the isolation they provide.
>
> Logan
