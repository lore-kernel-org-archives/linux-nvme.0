From: keith.busch@intel.com (Keith Busch)
Date: Mon, 24 Jul 2017 18:01:53 -0400
Subject: Test Unit Ready translation seems wrong in latest driver
In-Reply-To: <706a68b8482154bdf77efe7fb195fe24@mail.gmail.com>
References: <706a68b8482154bdf77efe7fb195fe24@mail.gmail.com>
Message-ID: <20170724220153.GB11979@localhost.localdomain>

On Mon, Jul 24, 2017@03:52:16PM -0600, Sathya Prakash Veerichetty wrote:
> The TUR translation returns LUN not ready when the controller is ready in
> the latest code whereas in the old code it returns LUN not ready only when
> the controller is not ready (proper behavior).

The latest code doesn't have a translation for TUR at all.
