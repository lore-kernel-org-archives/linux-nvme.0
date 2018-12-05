From: keith.busch@intel.com (Keith Busch)
Date: Wed, 5 Dec 2018 08:43:59 -0700
Subject: Whenever running nvme discover command, syslog shows warning
 messages
In-Reply-To: <BN6PR1301MB2001C46B2AA0738A52AEDD6885AF0@BN6PR1301MB2001.namprd13.prod.outlook.com>
References: <CY4PR1301MB2008564EA917C4FE4D63298585D20@CY4PR1301MB2008.namprd13.prod.outlook.com>
 <bdd5f3c7-8173-dd63-3a47-df87a9c2d14c@broadcom.com>
 <7a1a884d-5be0-064a-0865-51bca20ba919@grimberg.me>
 <CY4PR1301MB200823FB5DF08223456D9D1F85D30@CY4PR1301MB2008.namprd13.prod.outlook.com>
 <4fb9c4fc-e5ce-2238-fbcf-1fdd6da10e23@broadcom.com>
 <BN6PR1301MB2001C46B2AA0738A52AEDD6885AF0@BN6PR1301MB2001.namprd13.prod.outlook.com>
Message-ID: <20181205154359.GA18064@localhost.localdomain>

On Tue, Dec 04, 2018@10:27:26PM +0000, Ching-Chiao Chang wrote:
> It is not test case, we would like to run nvme discover in loop in an
> initiator, and whenever there is an NVMe volume can be attached, the
> the initiator can discover it and connect it automatically.

Polling for infrequent events is silly. Can we get an asynchronous event
notification for this? I don't see any exiting events pointing back to
the discovery log page, so maybe there's a TP opprotunity here.
