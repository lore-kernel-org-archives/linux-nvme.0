From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 31 Jul 2019 18:32:05 -0700
Subject: [PATCH v2 0/3] Support discovery log change events
In-Reply-To: <20190712180211.26333-1-sagi@grimberg.me>
References: <20190712180211.26333-1-sagi@grimberg.me>
Message-ID: <53ec841c-f71e-1789-1f7c-7ae3a0aa2d66@grimberg.me>


> We want to be able to support discovery log change events automatically
> without user intervention.
> 
> The definition of discovery log change events applies on "persistent" long
> lived controllers, so first we need to have discovery controllers to stay
> for a long time and accept kato value.
> 
> Then when we do happen to get a discovery log change event on the persistent
> discovery controller, we simply fire a udev event to user-space to re-query
> the discovery log page and connect to new subsystems in the fabric.
> 
> This works with James' latest nvme-cli patches.

James, I've applied this to nvme-5.4

Are you sending out the nvme-cli part? If you can make sure
that it works with what is in nvme-5.4 it will be great..

Thanks
