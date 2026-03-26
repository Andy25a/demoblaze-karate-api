package com.andii.demoblaze.api;

import com.intuit.karate.junit5.Karate;

class DemoblazeApiKarateSuite {

    @Karate.Test
    Karate runAll() {
        return Karate.run("classpath:karate/demoblaze_auth.feature");
    }
}
