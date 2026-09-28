public with sharing class LoyalityServiceClass {

    private static final Integer POINTS_PER_NIGHT = 10;


    @TestVisible
    private Integer goldthreshold = 500;


    public static Integer calculatepoints( Integer nightS){
        return nights * POINTS_PER_NIGHT;
    }



    public Boolean isGold(Integer points) {
        return points >= goldthreshold;
    }

       @TestVisible
        private String secretLabel() {
        return 'internal';
    }


  
    }
