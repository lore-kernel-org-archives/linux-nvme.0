From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 8 Nov 2018 02:03:14 -0800
Subject: [PATCH v2 11/11] nvmet: Enable Discovery Controller AENs
In-Reply-To: <1539709883-12424-12-git-send-email-jay.e.sternberg@intel.com>
References: <1539709883-12424-1-git-send-email-jay.e.sternberg@intel.com>
 <1539709883-12424-12-git-send-email-jay.e.sternberg@intel.com>
Message-ID: <20181108100314.GL29432@infradead.org>

>  	list_add_tail(&link->entry, &port->subsystems);
>  	nvmet_genctr++;
> +	nvmet_port_disc_change_event(port, subsys);

It seems like the increment of nvmet_genctr should move into
nvmet_port_disc_change_event / nvmet_subsys_disc_change_event.

I'd also name these functions similar to the namespace event handler,
e.g. nvmet_port_disc_changed / nvmet_subsys_disc_changed.
